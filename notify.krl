
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

			getName = function (x) { 
				array = x.extract(re#name=(\w*)#g)
				(array neq "") => string[0] | "Monkey"; 

			}; //join causes an array to be displayed as a string

			//name = (querString neq "") => getName(querString) | ""; 

			//print_Out = (name neq "") => name | "Monkey" ; 
			name = getName(querString);
			print_Out = name;

		}

		{ notify("Hello", "Hello " + print_Out) with sticky = true; };
	}
	/*rule count_rule is active{
		select when pageview ".*" setting()
		pre {
			count += 1
		}

		if (count<5) then { notify("View Count", "You have view this " + count + " times!") with sticky = true; };
	}

	rule count_clear is active{
		select when pageview ".*" setting()
		pre {
			querString= page:url("query");
			count = (querString.extract(re#clear#)) => 
		}
	}*/


	
}


