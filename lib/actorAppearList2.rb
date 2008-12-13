#I.e. you'd end up with a list of movies for each actor where they have appeared with one more other
#actors in more than one movie together.

#In Ruby/pseudo code I'm thinking something like :

#1)
#  For each actor in database :
#	for each movie_actor_has_appeared_in :
#		create_histogram_hash_keyed_on_other_actors_id

#2) collect movie names from histogram_hash for actor_appearance_count > 1

#3) repeat and rinse.


#  Tom Hanks
#  Meg Ryan
#

#@actors = Actor.find_all

#@actors = Appearance.find_all
@aplist = Aptest.find_all
@aalist = {}

@aplist.each {|appear|
	 @aalist[appear.actor.id] = {}
         #@movies = actor.movies
         @movies = []
         @aplist.each {|i| @movies.push(i.movie_id) if i.actor_id

	 @movies.each {|movie|
           @aalist[actor.id][movie.id] = {}
	   @actors_in_this_movie = movie.actors
	   @actors_in_this_movie.each {|actor|
		  @aalist[actor.id][movie.id][actor.id] +=1


}
