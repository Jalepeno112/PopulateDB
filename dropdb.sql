DROP TABLE movies CASCADE CONSTRAINTS PURGE;
DROP TABLE movie_genres PURGE;
DROP TABLE movie_directors PURGE;
DROP TABLE movie_countries PURGE;
DROP TABLE movie_actors PURGE;
DROP TABLE movie_locations PURGE;
DROP TABLE movie_tags PURGE;

DROP TABLE tags CASCADE CONSTRAINTS PURGE;

DROP TABLE user_ratedmovies_timestamps PURGE;
DROP TABLE user_ratedmovies PURGE;

DROP TABLE user_taggedmovies_timestamps PURGE;
DROP TABLE user_taggedmovies PURGE;
