
ruleset notification {
	meta {
		name "notifying"
		author "Ashlee"
		logging on
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
		pre { 
			querString= page:url("query");

			getName = function (x) { x.extract(re#name=(\w+)#g) };

			name = (querString neq "") => getName(querString) | ""; 

			print_Out = (name neq "") => name[0] | "Monkey" ; 

		}

		{ notify("Hello", "Hello " + print_Out) with sticky = true; };
	}

	
}


