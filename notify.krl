//b506537x3
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
				//array = x.extract(re#name=(\w+)#g); 
				array = x.extract(re/name=(\w+)/g); //x.extract(re/a(\w+)/g)
				(array.length()>0) => array.join(" ") | "Monkey"; 
			}; 

			name = getName(querString);
		}

		{ notify("Hello", "Hello " + name) with sticky = true; };
	}
	rule count_rule is active{			//testing out how online code works.
		select when pageview ".*" setting()
		pre {
			c = ent:count;
		}

		if (c<=5) then 
			notify("View Count", "You have viewed this " + c + " times!") with sticky = true; 

		fired {
			ent:count +=1 from 1;
		} 

	}

	rule count_clear is active{
		select when pageview ".*" setting()
		pre {
			querString= page:url("query");
			cclear = querString.extract(re#(clear)#);
			c = ent:count;
		}

		if c>5 && cclear.length()>0 then
			notify("Reset", "We're resetting your count!") with sticky = true;

		fired{
			clear ent:count;
		}
	}
	
}


