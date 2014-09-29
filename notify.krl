
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
	rule notify is active {
		select when pageview ".*" setting()
		{ notify("This is a notification.", "Now you know!") with sticky = true;
		notify("Hey look!", "Another notification!") with sticky = true and color = "#CC9";}
	}
	rule notify2 is active {
		select when pageview ".*" setting()
		
		pre { querString= page:url("query");
			x=querString}

		//if querString==0 then x="Hello Monkey";
		if (querString) then {      							//Problem: != doesn't print it but == prints it... it's obviously not null if it's printing it out. I don't understand the null aspect. so check out how to do an if/else statement or how to better use the string? not sure. j
			notify("Hello", querString) with sticky = true;
		}

		if (not querString) then {
			notify("Hello World!", "Hello Monkey") with sticky = true;
		}
	}
}