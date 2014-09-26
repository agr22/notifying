
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
		
		//if querString: 0 then x="Hello Monkey"
		//notify("Hello", x) with sticky = true;
		//notify("Hello", /*page:url("query")*/ );
		pre {x=1;
			querString= page:url("query");
			x=querString}

		//notify("Hello", querString) with sticky = true;

		if querString == null then {
			notify("Hello", querString) with sticky = true;
		}
		if querString=="" then {
			notify("Hello World!", "Hello Monkey") with sticky = true;
		}
	}
}