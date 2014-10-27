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
				<p>Insert your first and last name!</p>
				<form id="my_form" onsubmit="return false">
					<input type="text" name="first"/>
					<input type="text" name="last"/>
					<input type="submit" name="Submit"/>
				</form>
			>>;

		}
		
		if(not ent:first) then {
			append("#main", add_paragraph + a_form);
			watch("#my_form", "submit");
		}

		//notify("Showing the Paragraph", add_paragraph) with sticky=true;
		
		/*fired {
			last;
		}*/

	}

	rule respond_submit {
		select when web submit "my_form"
		pre {
			username = event:attr("first")+" "+event:attr("last");
		}
		replace_inner("my_div", "Hello #{username}");
		fired {
			set ent:username username;
		}

	}

	
}

