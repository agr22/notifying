//
ruleset rotten_tomatoes {
	meta {
		name "Rotten Tomatoes API Exercise"
		author "Ashlee"
		logging on
	}
	dispatch {
		domain "http://ktest.heroku.com"
	}
	global {
		dataset tomatoes_api <- http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json");
	}
	
	rule show_form {

	}

}