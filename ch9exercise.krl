//https://cs.kobj.net/sky/event/03CC5B2C-7048-11E4-AA79-BDE2387E45AE/123/foursquare/checkin
//b506537x6.prod
ruleset ch9exercise {
	meta {
		name "Chapter Nine Exercises - Four Square"
		author "Ashlee"
		logging on
		use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
	}
		
	global {
		
	}

	rule process_fs_checkin {
		select when foursquare checkin
		pre {
			checkin_map = event:attr("checkin").decode();
			venue = checkin_map.pick("$..venue");
			venue_name = checkin_map.pick("$.venue[0].name");
			/*ent:city = event:attr("city");
			ent:shout = event:attr("shout");
			ent:createdAt = event:attr("createdAt");*/
		}
		{
		send_directive("Foursquare Check-In") with checkin = "I have arrived";
		}

		fired {
			set ent:venue venue;
			set ent:checkin_map checkin_map;
			set ent:venue_name venue_name;
			
		}
		
	}
	

	rule display_checkin is active {
    	select when web cloudAppSelected
    	pre {
	    	v = ent:venue.pick("$.name").as("str");
	    	data = ent:checkin_map.encode();

	    	//venue_name = ent:venue_name;
	      my_html = <<
	        <h5>Hey! Foursquare!</h5>
	        <p>I was here: #{ent:venue}</p> 
	        <p>Trying to show something: #{ent:checkin_map}</p>
	        <p>Trying to show something else: #{ent:data}</p>
	        <p>Should be venue name: #{ent:venue_name}</p>
	      >>;
	    }
	    {
	      SquareTag:inject_styling();
	      CloudRain:createLoadPanel("Foursquare", {}, my_html);
	    }
	 }

}