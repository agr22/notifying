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
			
			name_form = <<
				<div id="my_div"> 
					<p>Insert your first and last name!</p>
				</div>
				<form id="my_form" onsubmit="return false">
					<input type="text" name="first"/> <br>
					<input type="text" name="last"/> <br>
					<input type="submit" name="Submit"/>
				</form>
				<div id="add_intro">
					<p></p>
				</div>
			>>;

		}
		
		if(not ent:first) then {
			append("#main", name_form);
			watch("#my_form", "submit");
		}

	}

	rule respond_submit {
		select when web submit "#my_form"
		pre {
			firstName = event:attr("first");
			lastName = event:attr("last");
		}
		replace_inner("#add_intro", "Hello #{firstName} #{lastName}");

		fired {
			set ent:firstName firstName;
			set ent:lastName lastName;
			//last;
		}

	}

	rule replace_with_name {		//This makes it so if I re-enter the page, the values stay there
		select when web pageview ".*"		//problem: this automatically comes up from the start...
		
		pre {
			firstName = ent:firstName;		//how does this pick up nothing if I haven't submitted?
			lastName = ent:lastName;
		}
		if (firstName.length()>0 || lastName.length()>0) then
			replace_inner("#add_intro", "Hello #{firstName} #{lastName}");
	}

	rule clear_input {
		select when pageview ".*" setting()
		pre {
			queryString= page:url("query");
			inputClear = queryString.extract(re#(clear=1)#);
		}

		if inputClear.length()>0 then
			notify("Clear", "We're clearing the username!") with sticky = true;

		fired{
			clear ent:firstName;
			clear ent:lastName;
		}
	}



	
}

