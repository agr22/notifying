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

			a_form = <<
				<form id="my_form" onsubmit="return false">
					<input type="text" name="first"/>
					<input type="text" name="last"/>
					<input type="submit" name="Submit"/>
				</form>
			>>;

		}
		{
		notify("Showing the Paragraph", add_paragraph) with sticky=true;
		}
		/*watch("#my_form", "submit");
		
		fired {
			last;
		}*/
	}

	
	
}

