
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

			getName = function (x) { 
				x.extract(re#(name=)(\w+)#g)
			};
			name = getName(querString);//name = querString.extract(re#(name=)(\w*)#g); //getName(querString);
			//name = querString.extract(re#(name=)(\w*)#g);			
			print_Out = (name neq "") => name[1] | "Monkey" ; 
			//print_Out = "";
		}

		}
			//how can I have querString return false? I've tried with "" but it doesn't seem to be working

		//{ notify("Hello", "Hello" + print_Out) with sticky = true; }

		{ notify("This is a notification", "Hello " + print_Out) with sticky = true; };
	}

	
}


