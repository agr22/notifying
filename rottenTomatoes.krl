//b506537x5.prod
ruleset rotten_tomatoes {
	meta {
		name "Rotten Tomatoes API Exercise"
		description << Rotten Tomatoes >>
		author "Ashlee"
		logging on
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
				<form id="my_form" onsubmit="return false">
					Insert a movie title! <input type="text" name="movie"/><br>
					<input type="submit" name="Submit"/>
				</form>
			>>;
		}

		{
     	 	replace_inner("#main", my_html);
     	 	watch("#my_form", "submit");
    	}

	}

	rule display_movie {
		select when web submit "#my_form"
		pre {
			movieName = event:attr("movie");
			movie_info = tomatoes_api(movieName);

			getTitle = "Movie Title: <p>" + movie_info{"title"} + "</p>";
			getThumbnail = "Thumbnail: <p>" + movie_info{"thumbnail"} + "</p>";
			getReleaseYear = "Release Year: <p>" + movie_info{"year"} + "</p>";
			getSynopsis = "Synopsis: <p>" + movie_info{"synopsis"} + "</p>";
			getCriticRatings = "Critic Ratings: <p>" + movie_info{"critics_rating"} + "</p>";

			/*movie_info_print = <<
				<p>The Movie you searched for:</p>
				<div id="a_div"> 
					Movie:<p>#{getTitle}</p>
				</div>	
			>>;*/
			movie_info_print = getTitle + getThumbnail + getReleaseYear + getSynopsis + getCriticRatings;
		}

		{
		notify("Hey", movie_info_print) with sticky = true;
		append("#my_form", "#{movie_info_print}" );
		}
	}

}

