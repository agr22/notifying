
ruleset notification {
	meta {
		name "notifying"
		author "Ashlee"
		logging off
		use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
	}
	dispatch {

	}
	global{

	}
	rule notify is active {
		notify("This is a notification.", "Now you know!") with sticky = true;
	}
}