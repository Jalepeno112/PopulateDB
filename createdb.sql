-- Movie columns - 	id	title	imdbID	spanishTitle	imdbPictureURL	year
--			rtID	rtAllCriticsRating	rtAllCriticsNumReviews	rtAllCriticsNumFresh
-- 			rtAllCriticsNumRotten	rtAllCriticsScore	rtTopCriticsRating	rtTopCriticsNumReviews
-- 			rtTopCriticsNumFresh	rtTopCriticsNumRotten	rtTopCriticsScore	rtAudienceRating	rtAudienceNumRatings	rtAudienceScore	rtPictureURL

CREATE TABLE movies(
	id 			NUMBER PRIMARY KEY,
	title 			VARCHAR2(150) NOT NULL,
	imdbID 			VARCHAR2(20) NOT NULL,
	spanishTitle		VARCHAR2(150),
	imdbPictureURL		VARCHAR2(2083),
	year 			VARCHAR2(5),
	rtID 			VARCHAR2(100),
	rtAllCriticsRating	NUMBER,
	rtAllCriticsNumReviews	NUMBER,
	rtAllCriticsNumFresh 	NUMBER,
	rtAllCriticsNumRotten	NUMBER,
	rtAllCriticsScore 	NUMBER,
	rtTopCriticsRating	NUMBER,
	rtTopCriticsNumReviews	NUMBER,
	rtTopCriticsNumFresh	NUMBER,
	rtTopCriticsNumRottenh	NUMBER,
	rtTopCriticsScore 	NUMBER,
	rtAudienceRating 	NUMBER,
	rtAudienceNumRatings 	NUMBER,
	rtAudienceScore 	NUMBER,
	rtPictureURL 		VARCHAR2(2083)
);
-- INSERT INTO movies VALUES(1, 'Toy story', 0114709, 'Toy story (juguetes)', 'http://ia.media-imdb.com/images/M/MV5BMTMwNDU0NTY2Nl5BMl5BanBnXkFtZTcwOTUxOTM5Mw@@._V1._SX214_CR0,0,214314_.jpg', '1995', 'toy_story', 9, 73, 73, 0, 100, 8.5, 17, 17, 0, 100, 3.7, 102338, 81, 'http://content7.flixster.com/movie/10/93/63/10936393_det.jpg');


-- Movie Genere columns - 	movie_id, genre

CREATE TABLE movie_genres(
	movie_id 	NUMBER,
	genre 		VARCHAR2(30) NOT NULL,
	FOREIGN KEY(movie_id) REFERENCES movies(id)
		ON DELETE CASCADE,
	PRIMARY KEY(movie_id, genre)
);
-- INSERT INTO movie_genres VALUES(1, 'Adventure');
-- INSERT INTO movie_genres VALUES(1, 'Commedy');

-- movie directors - 	movieID		directorID	directorName

CREATE TABLE movie_directors(
	movieID 	NUMBER NOT NULL UNIQUE,
	directorID 	VARCHAR2(30) NOT NULL,
	directorName 	VARCHAR2(70) NOT NULL,
	PRIMARY KEY (movieID, directorID),
	FOREIGN KEY (movieID) REFERENCES movies(id)
		ON DELETE CASCADE
);
-- INSERT INTO movie_directors VALUES(1, 'john_lasseter', 'John Lasseter');

-- movie countries -  	movieID  	country
CREATE TABLE movie_countries(
	movieID 	NUMBER NOT NULL UNIQUE,
	country 	VARCHAR2(70) NOT NULL,
	PRIMARY KEY(movieID, country),
	FOREIGN KEY(movieID) REFERENCES movies(id)
		ON DELETE CASCADE
);
-- INSERT INTO movie_countries VALUES(1, 'USA');

-- movie_actors - movieID actorID actorName   ranking
CREATE TABLE movie_actors(
	movieID 	NUMBER NOT NULL,
	actorID 	VARCHAR2(30) NOT NULL,
	actorName	VARCHAR2(70) NOT NULL,
	ranking 	NUMBER NOT NULL,
	PRIMARY KEY (movieID, actorID),
	FOREIGN KEY (movieID) REFERENCES movies(id)
		ON DELETE CASCADE
);
-- INSERT INTO movie_actors VALUES(1, 'annie_potts', 'Annie Potts', 10);
-- INSERT INTO movie_actors VALUES(1, 'bill_farmer', 'Bill Farmer', 20);


-- movie_locations - 	     movieID location1   location2   location3   location4
CREATE TABLE movie_locations(
	movieID 	NUMBER NOT NULL,
	location1	VARCHAR2(70),
	location2	VARCHAR2(70),
	location3	VARCHAR2(70),
	location4 	VARCHAR2(70),
	-- PRIMARY KEY(movieID, location1, location2, location3, location4),
	FOREIGN KEY(movieID) REFERENCES movies(id)
		ON DELETE CASCADE
);
-- INSERT INTO movie_locations VALUES(1, NULL, NULL, NULL, NULL);

-- tags - 	id  value
CREATE TABLE tags(
	id 	NUMBER PRIMARY KEY,
	value 	VARCHAR2(70) NOT NULL
);
-- INSERT INTO tags VALUES(7, 'funny');

-- movie_tags - 	    1 movieID tagID   tagWeight

CREATE TABLE movie_tags(
	movieID 	NUMBER NOT NULL,
	tagID	 	NUMBER NOT NULL,
	tagWeight	NUMBER NOT NULL,
	PRIMARY KEY(movieID, tagID),
	FOREIGN KEY(movieID) REFERENCES movies(id)
		ON DELETE CASCADE,
	FOREIGN KEY(tagID) REFERENCES tags(id)
		ON DELETE CASCADE
);
-- INSERT INTO movie_tags VALUES(1,7,1);

-- user_ratedmovies-timestamp - 	userID  movieID rating  timestamp
CREATE TABLE user_ratedmovies_timestamps(
	userID 		NUMBER NOT NULL,
	movieID 	NUMBER NOT NULL,
	rating 		NUMBER NOT NULL,
	timestamp 	NUMBER NOT NULL,
	PRIMARY KEY(userID, movieID),
	FOREIGN KEY(movieID) REFERENCES movies(id)
		ON DELETE CASCADE
);
-- INSERT INTO user_ratedmovies_timestamps VALUES (170, 1, 3, 1162208198000);


-- user_ratedmovies - userID  movieID rating  date_day    date_month  date_year   date_hour   date_minute date_second
CREATE TABLE user_ratedmovies(
	userID 		NUMBER NOT NULL,
	movieID 	NUMBER NOT NULL,
	rating 		NUMBER NOT NULL,
	date_day 	NUMBER NOT NULL,
	date_month 	NUMBER NOT NULL,
	date_year 	NUMBER NOT NULL,
	date_hour 	NUMBER NOT NULL,
 	date_minute 	NUMBER NOT NULL,
	date_second 	NUMBER NOT NULL,
	PRIMARY KEY(userID, movieID),
	FOREIGN KEY(movieID) REFERENCES movies(id)
		ON DELETE CASCADE
);
-- INSERT INTO user_ratedmovies VALUES(75, 1, 1, 29, 10, 2006, 23, 17, 16);


-- user_taggedmovies - userID  movieID tagID   date_day    date_month  date_year   date_hour   date_minute date_second
CREATE TABLE user_taggedmovies(
	userID 		NUMBER NOT NULL,
	movieID 	NUMBER NOT NULL,
	tagID 		NUMBER NOT NULL,
	date_day 	NUMBER NOT NULL,
	date_month 	NUMBER NOT NULL,
	date_year 	NUMBER NOT NULL,
	date_hour 	NUMBER NOT NULL,
 	date_minute 	NUMBER NOT NULL,
	date_second 	NUMBER NOT NULL,
	PRIMARY KEY(userID, movieID),
	FOREIGN KEY(movieID) REFERENCES movies(id)
		ON DELETE CASCADE,
	FOREIGN KEY(tagID) REFERENCES tags(id)
		ON DELETE CASCADE
);
-- INSERT INTO user_taggedmovies VALUES(75, 1, 7, 29, 10, 2006, 23, 17, 16);

-- user_taggedmovies-timestamp - 	userID  tagID rating  timestamp
CREATE TABLE user_taggedmovies_timestamps(
	userID 		NUMBER NOT NULL,
	movieID 	NUMBER NOT NULL,
	tagID	 	NUMBER NOT NULL,
	timestamp 	NUMBER NOT NULL,
	PRIMARY KEY(userID, movieID, tagID),
	FOREIGN KEY(movieID) REFERENCES movies(id)
		ON DELETE CASCADE,
	FOREIGN KEY(tagID) REFERENCES tags(id)
		ON DELETE CASCADE
);
-- INSERT INTO user_taggedmovies_timestamps VALUES (170, 1, 7, 1162208198000);


CREATE OR REPLACE VIEW movie_view AS
	SELECT
		movie_group.movie_id as movie_id,
		movie_group.movie_title as movie_title,
		movie_group.actor_name as actor_name,
		movie_group.country as country,
		movie_group.director_name as director_name,
		movie_genres.genres as movie_genres,
		movie_group.average_rating as average_rating,
		movie_group.num_ratings as num_ratings,
		movie_group.year as movie_year
	FROM (
		SELECT DISTINCT
			movies.id as movie_id,
			movies.title as movie_title,
			movie_actors.actorname as actor_name,
			movie_countries.country as country,
			movie_directors.directorname as director_name,
			movies.year as year,
			(movies.rtAllCriticsRating + movies.rtTopCriticsRating + movies.rtAudienceRating) / 3.0 as average_rating,
			rtAllCriticsNumReviews + rtTopCriticsNumReviews + rtAudienceNumRatings as num_ratings
		FROM movies, movie_countries, movie_actors, movie_directors
		WHERE movies.id = movie_countries.movieid
		AND movie_actors.movieid = movies.id
		AND movie_directors.movieid = movies.id
	) movie_group
	INNER JOIN (
		SELECT movie_id,
		LISTAGG(genre, ', ') WITHIN GROUP (ORDER BY genre) genres
		FROM movie_genres GROUP BY movie_id
	) movie_genres
	ON movie_group.movie_id = movie_genres.movie_id;

	--CREATE VIEW movie_ratings_view AS
	--SELECT
--		movies.id as movie_id,
