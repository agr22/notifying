
ruleset notification {
	meta {
		name "notifying"
		author "Ashlee"
		logging on
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
		pre { 
			querString= page:url("query");

			getName = function (x) { x.extract(re#name=(\w+)#g) };

			name = getName(querString);

			print_Out = (not name eq "") => name[0] | "Monkey" ; 

		}
			//how can I have querString return false? I've tried with "" but it doesn't seem to be working

		//{ notify("Hello", "Hello" + print_Out) with sticky = true; }

		{ notify("Hello", "Hello " + print_Out) with sticky = true; };
	}

	
}


