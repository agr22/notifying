
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
			print_Out = (3>4) => querString | "Monkey" ;
		}

		{ notify("Hello", print_Out) with sticky = true; }
		/*if (not querString) then {
			x = ""; //use ch 7 more. still figuring this out.... figure out what "fired" means
		}
		fired {
			notify("Hello", querString) with sticky = true;
		} else {
			notify("Hello World!", "Hello Monkey") with sticky = true;
		}*/

		//(querString) => "yellow"; | "Monkey";

		//function replace_with_name (querString) {		//trying something new

		//}

		//notify("Hello", "Hello #{x}") with sticky = true;
		/*if (querString) then {      							//Problem: != doesn't print it but == prints it... it's obviously not null if it's printing it out. I don't understand the null aspect. so check out how to do an if/else statement or how to better use the string? not sure. j
			notify("Hello", querString) with sticky = true;
		}

		if (not querString) then {
			notify("Hello World!", "Hello Monkey") with sticky = true;
		}*/
	}
}


