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
		
		tomatoes_api = function(searchTitle) {http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
											{"apikey": "waiting on this",
											 "q": searchTitle,
											 "page_limit": 1});
								}
	}
	
	rule sqTagApp {
		select when web cloudAppSelected
		pre {
			my_html = <<
				<div id="add_movie_info">
					<p></p>
				</div>
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
     	 	watch("#form", "submit");
    	}

	}

	rule display_movie {
		select when web submit "#my_form"
		pre {
			movieName = event:attr("movie");

			movie_info_print = <<
				<p>The Movie you searched for:</p>
				<div id="my_div"> 
					<p>Insert a movie title!</p>
				</div>
				
			>>;

			movie_info = tomatoes_api(movieName);
			getTitle = movie_info.pick("$.movies[0].title");



		}
		replace_inner("#add_movie_info", "#movie_info_print");
	}

}

