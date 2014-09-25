
ruleset notification {
	meta {
		name "notifying"
		author "Ashlee"
		logging off
		use module a421x47 alias SauceLabs
	}
	dispatch {
		domain ktest.heroku.com
	}
	global{

	}
	rule notify is active {
		select when pageview ".*" setting()
		notify("This is a notification.", "Now you know!") with sticky = true
	}
}