//https://cs.kobj.net/sky/event/03CC5B2C-7048-11E4-AA79-BDE2387E45AE/123/foursquare/checkin
ruleset ch9exercise {
	meta {
		name "Chapter Nine Exercises - Four Square"
		author "Ashlee"
		logging on
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
		
		notify("Process", "This ran") with sticky = true;
		fired {
			set ent:venue venue;
			//
		}
		
	}

	rule display_checkin {
		select when foursquare checkin
		notify("The entity variables",ent:venue); //+ ent:city + ent:shout + ent:createdAt)
	}

}