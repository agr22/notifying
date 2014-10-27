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
			/*add_paragraph = <<
				<div id="my_div">
					<p>Insert your first and last name!</p>
				</div>
			>>;*/

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
			append("#main", a_form);
			watch("#my_form", "submit");
		}

	}

	rule respond_submit {
		select when web submit "#my_form"
		pre {
			username = event:attr("first")+" "+event:attr("last");
		}
		append("#main", "Hello #{username}");

		fired {
			set ent:username username;
		}

	}

	
}

