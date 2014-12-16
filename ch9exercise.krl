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
			city = checkin_map.pick("$..city");
			shout = checkin_map.pick("$..city");
			createdAt = checkin_map.pick("$..city");
		}
		{
		send_directive("Foursquare Check-In") with checkin = checkin_map;
		}

		fired {
			set ent:venue venue;
			set ent:checkin_map checkin_map;
		//	set ent:venue_name venue_name;
		//	set ent:data data;
			set ent:city city;
			
		}
		
	}
	

	rule display_checkin is active {
    	select when web cloudAppSelected
    	pre {
	    	v = ent:venue.pick("$..name").as("str");
	    	venue = ent:venue.as("str");
	    	v2 = ent:venue.pick("$..name[0]").as("str");


	    	//venue_name = ent:venue_name;
	      my_html = <<
	        <h5>Hey! Foursquare!</h5>
	        <p>I was here: #{venue}</p> 
	        <p>Should be venue name maybe?: #{v}</p>
	        <p>I was here 2: #{v2}</p> 
	        <p>city:</p>
	      >>;
	    }
	    {
	      SquareTag:inject_styling();
	      CloudRain:createLoadPanel("Foursquare", {}, my_html);
	    }
	 }


}