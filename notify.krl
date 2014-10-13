
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
				array = x.extract(re#name=(\w+)#g);
				(array.length()>0) => array.join(" ") | "Monkey"; 
			}; 

			name = getName(querString);
		}

		{ notify("Hello", "Hello " + name) with sticky = true; };
	}
	rule count_rule is active{			//testing out how online code works.
		select when pageview ".*" setting()
		pre {
			count = ent:archive_pages
		}

		if (count<5) then 
		 notify("View Count", "You have view this " + count + " times!") with sticky = true; 
		fired {
			clear ent:archive_pages;
		} else {
			ent:archive_pages +=1 from 1;
		}

	}

	/*rule count_clear is active{
		select when pageview ".*" setting()
		pre {
			querString= page:url("query");
			count = (querString.extract(re#clear#)) => 
		}
	}*/


	
}


