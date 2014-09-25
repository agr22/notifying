
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
	rule notify is active {
		select when pageview ".*" setting()
		notify("This is a notification.", "Now you know!") with sticky = true;
		notify("Hey look!", "Another notification!") with sticky = true and color = "#CC9" and position = "bottom-right";
	}
}