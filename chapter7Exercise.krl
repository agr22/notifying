//b506537x4.prod
ruleset chapter_Seven {
	meta {
		name "Chapter Seven Exercises"
		author "Ashlee"
		logging on
	}
	dispatch {
		domain "http://ktest.heroku.com"
	}
	global {
		
	}
	
	rule show_form {			
		select when pageview ".*" setting()
		
		pre {
			add_paragraph = <<
				<div id="my_div">
					<p>Hey this is a paragraph</p>
				</div>
			>>;
		}
		notify("Showing the Paragraph", my_div) with sticky=true;

	}

	
	
}


