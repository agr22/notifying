
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
	
	rule show_form is active{			//testing out how online code works.
		select when pageview ".*" setting()
		
		pre {
			add_paragraph = <<
				<div>
					<p>"Hey this is a paragraph"</p>
				</div>
			>>;
		}

	}

	
	
}


