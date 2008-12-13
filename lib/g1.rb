###############################################################
#  1 Peter Sellers
#    	      1  BiCentennial Man         **************
#                             2 - George C. Scott
#                             3 - Robin Williams
#             2  The Party
#                             2 -  George C. Scott
#
#             5  The ShawShank Redemption ***************
#                             3 -  Robin Williams
###############################################################
#  2 George C. Scott
#             1  BiCentennial Man
#                             1 Peter Sellers
#                             3 - Robin Williams
#             2  The Party
#                             1 Peter Sellers
################################################################
#  3 Robin Williams
#	     1  BiCentennial Man           *****
#                             1 Peter Sellers
#
#            5  The ShawShank Redemption   *******
#                             1 Peter Sellers
################################################################
def t4
actor_actors = {}
@actors=Actor.find_all
@actors.each {|actor|  print "\n #{actor.first_name} #{actor.last_name}" ; actor_actors[actor] = {}
               actor.movies.each {|movie|  print "\n\t #{movie.name}" ;
                actor_actors[actor] = {}
                actor_actors[actor][movie] = Hash.new(0)
                 movie.actors.each {|mactor|

                     if actor != mactor
                        actor_actors[actor][mactor] = []
                        actor_actors[actor][mactor].push(movie)
                     end
                     print "\n\t #{mactor.last_name} #{actor_actors[actor][movie][mactor]}"
                 }
              }
         }
end

def t3
 @alist = Aptest.find_all.sort_by {|a| a.actor_id}
 @alist.each {|a|
end


def t2
# @actors = Actor.find_all
# @actors.each {|actor|
#  @actor_movies = Hash.new(0)
#   @movies = actor.movies
#   @movies.each {|movie|
#    @actors2 = movie.actors
#      @actor2.each {|actor2| @actor_movies[actor2] += 1}
end

def t1
 print "t1 v.001\n\n"
 @aalist = {}

 @aplist = Aptest.find_all

 # Aptest
 #  id, movie_id, actor_id, character_name
 #

 g=@aplist.group_by {|a| a.actor_id}

 #  g[actor_id] = id, movie_id, actor_id, character_name
 #
 #  g[1] = id =>1, movie_id =>1, actor_id =>1, character_name => ...., id => ..
 #
 #

 g.each_pair {|aid,apps|
    @lastname = Actor.find(aid).last_name
    @firstname = Actor.find(aid).first_name
    @fullname = @firstname + @lastname
    print "\n\n Actor id = #{aid} #{@fullname}"
#    print "\n apps = #{apps}"

    apps.each {|ap|
                    print "\n movie #{ap.movie_id}  actor #{ap.actor_id}"
               }
               print "\n"
   }
 end

