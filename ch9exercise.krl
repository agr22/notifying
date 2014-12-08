//https://cs.kobj.net/sky/event/03CC5B2C-7048-11E4-AA79-BDE2387E45AE/123/foursquare/checkin
//b506537x6.prod
ruleset ch9exercise {
	meta {
		name "Chapter Nine Exercises - Four Square"
		author "Ashlee"
		logging on
		use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
		//apikeys
		//provides send
	}
		
	global {
		//send = defaction(title, description){}

		
	}
	rule process_fs_checkin {
		select when foursquare checkin
		pre {
			check_in = event:attr("checkin").decode();
			venue = checkin.pick("$..venue");
			/*ent:city = event:attr("city");
			ent:shout = event:attr("shout");
			ent:createdAt = event:attr("createdAt");*/
		}
		
		send_directive("Foursquare Check-In") with checkin = "I have arrived";
		emit <<
			console.log("the checkin process ran")
		>>
		fired {
			set ent:venue venue;
			//
		}
		
	}
	/*rule notification {
		select when pageview ".*" 
		notify("Trying to see", ent:venue)
	}*/

	rule display_checkin {
		select when foursquare checkin
		pre{
			v=ent:venue;
		}
		notify("The entity variables",v.as("str")); //+ ent:city + ent:shout + ent:createdAt)
	}

	rule HelloWorld is active {
    select when web cloudAppSelected
    pre {
    	v=ent:venue;
    	new_v=v.as("str");
      my_html = <<
        <h5>Hey! Foursquare!</h5>
        <p>#{new_v}</p> 
      >>;
    }
    {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Foursquare", {}, my_html);
    }
  }

}