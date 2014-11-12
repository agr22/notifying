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
				
				json_from_url;
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
					<p>Insert a movie title! update</p>
				</div>
				<form id="my_form" onsubmit="return false">
					<input type="text" name="movie"/>
					<input type="submit" name="Submit"/>
				</form>
			>>;
		}

		{
      		//SquareTag:inject_styling(); //remove this and do replace_inner
     	 	CloudRain:createLoadPanel("Rotten Tomatoes", {}, my_html);
     	 	//replace_inner("#main", my_html);
     	 	watch("#my_form", "submit");
    	}

	}

	rule display_movie {
		select when web submit "#my_form"
		pre {
			movieName = event:attr("movie");
			//movie_rt = tomatoes_api(movieName);

				//movieThumbnail = movie_rt.pick($.thumbnail);
				//title = movie_rt.pick($.title);
				//releaseYear = movie_rt.pick($.release_date[0]);
				//synopsis = movie_rt.pick($.synopsis);
				//criticRatings = movie_rt.pick();


			movie_info_print = <<
				<p>The Movie you searched for:</p>
				<div id="my_div"> 
					<p>Insert a movie title!</p>
				</div>
				
			>>;

			movie_info = tomatoes_api(movieName);
			getYear = movie_info{["0", "year"]};



		}
		//replace_inner("#add_movie_info", "Year #{getYear}");
		//replace_inner("#add_movie_info", "Hello");
		notify("JSON:", movie_info) with sticky = true;
		notify("Hey", getYear) with sticky = true;
	}

}

