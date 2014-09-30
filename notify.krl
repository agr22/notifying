
ruleset notification {
	meta {
		name "notifying"
		author "Ashlee"
		logging off
		//use module a421x47 alias SauceLabs
	}
	dispatch {
		domain "http://ktest.heroku.com"
	}
	global {
		
	}
	rule notifying_rule1 is active {
		select when pageview ".*" setting()
		{ notify("This is a notification.", "Now you know!") with sticky = true;
		notify("Hey look!", "Another notification!") with sticky = true and color = "#CC9";}
	}
	rule notifing_rule2 is active {
		select when pageview ".*" setting()
		
		pre { querString= page:url("query");
			print_Out = (querString.match("")) => querString | "Monkey" ;
		}


		{ notify("Hello", print_Out) with sticky = true; }
		
	}
}


