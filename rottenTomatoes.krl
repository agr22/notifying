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

	global {
		tomatoes_api = function(searchTitle) {
				val = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
							{"apikey": "8tyyqkacg5r5wk57kaakrzzd",
							 "q": searchTitle,
							 "page_limit": 1});
				json_from_url = val.pick("$.content").decode();
				pick_movies = json_from_url.pick("$.movies");
				first_movie = pick_movies[0];

				first_movie;
			}
	}
	
	rule sqTagApp {
		select when web pageview ".*"	
		pre {
			my_html = <<
				<div id="my_div"> 
					<p>Insert a movie title! update</p>
				</div>
				<form id="my_form" onsubmit="return false">
					<input type="text" name="movie"/><br>
					<input type="submit" name="Submit"/>
				</form>
			>>;
		}

		{
      		//SquareTag:inject_styling(); //remove this and do replace_inner
     	 	//CloudRain:createLoadPanel("Rotten Tomatoes", {}, my_html);
     	 	replace_inner("#main", my_html);
     	 	watch("#my_form", "submit");
    	}

	}

	rule display_movie {
		select when web submit "#my_form"
		pre {
			movieName = event:attr("movie");

			movie_info = tomatoes_api(movieName);
			getTitle = movie_info{"title"};

			movie_info_print = <<
				<p>The Movie you searched for:</p>
				<div id="a_div"> 
					<p>Movie: #{getTitle}</p>
				</div>
				
			>>;

			



		}
		//replace_inner("#add_movie_info", "Year #{getYear}");
		//replace_inner("#add_movie_info", "Hello");
		{
		notify("Hey", movie_info_print) with sticky = true;
		append("#my_form", movie_info_print);
		//notify("Info about that movie", "Name: " + movie_info{"title"} + "") with sticky = true;
		//notify("Info about that movie", "Year: " + movie_info{"year"} + "") with sticky = true;
		}
	}

}

