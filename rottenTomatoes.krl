//b506537x5.prod
ruleset rotten_tomatoes {
	meta {
		name "Rotten Tomatoes API Exercise"
		description << Rotten Tomatoes >>
		author "Ashlee"
		logging on
		use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
	}
	dispatch {
		domain "http://ktest.heroku.com"
	}
	global {
		//dataset tomatoes_api <- http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json");
	}
	
	rule sqTagApp {
		select when web cloudAppSelected
		pre {
			my_html = <<
				<div id="my_div"> 
					<p>Insert a movie title!</p>
				</div>
				<form id="my_form" onsubmit="return false">
					<input type="text" name="movie"/>
					<input type="submit" name="Submit"/>
				</form>
			>>;
		}

		{
      		SquareTag:inject_styling();
     	 	CloudRain:createLoadPanel("Rotten Tomatoes", {}, my_html);
    	}

	}

}

