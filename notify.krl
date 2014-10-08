
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
		pre { querString= page:url("query");
			//getName = function (x) {
				//x.extract(re# (?name=) (\w*)#g);
			//}

			name = querString.extract(re#(name=)(\w*)#g);			//figuring this out					//	([^&]*)/);
			print_Out = (querString neq "") => querString | "Monkey" ; //must be declared in pre	//(\w+)#);
			//print_Out = "";

		}

		/*if (querString.match("")) then
		fired {
			print_Out = querString;
		} else {
			print_Out = "Monkey";
		}*/
		
		/*fired {
			naming = function(query_Name){
				(querString.match("")) => name[0] 
										| "Monkey"
			}
		}*/

		//{ notify("Hello", "Hello" + print_Out) with sticky = true; }
		{ notify("Hello", "Hello " + name[1]) with sticky = true; }
	}
}


