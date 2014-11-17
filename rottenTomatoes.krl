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
					<p>Insert a movie title!</p>
					<input type="text" name="movie"/><br>
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

			getTitle = "Movie Title: " + movie_info{"title"} + "<br>";
			getThumbnail = "Thumbnail: <img src =" + movie_info{"thumbnail"} + "/><br>";
			getReleaseYear = "Release Year: " + movie_info{"year"} + "<br>";
			getSynopsis = "Synopsis: " + movie_info{"synopsis"} + "<br>";
			getCriticRatings = "Critic Ratings: " + movie_info{"$..critics_rating"} + "<br>";
			//how can I get the critic ratings without using pick? is pick more efficient?


			movie_info_print = (movie_info.pick("$.total") == null) => "<p>I'm sorry, that didn't return anything. Please enter the name a of different movie.</p><br>" | "<p>" + getTitle + getThumbnail + getReleaseYear + getSynopsis + getCriticRatings + "</p>";
		}

		{
		//notify("Hey", movie_info.pick("$.total")) with sticky = true;
		append("#my_form", "#{movie_info_print}" );
		}
	}

}

