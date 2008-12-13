
# Josh Susser Blog -
#http://blog.hasmanythrough.com/2006/06/12/when-associations-arent-enough-part-2

#

# +----+----------+----------+----------------+
# | id | actor_id | movie_id | character_name |
# +----+----------+----------+----------------+
# |  1 |        1 |        1 | NULL           | Sellers , Bicentennial Man
# |  2 |        1 |        2 | NULL           | 	, The Party
# |  3 |        1 |        3 | NULL           | 	, Dr. Strangelove

# |  4 |        4 |        8 | NULL           | Hanks	, Caddy Shack

# |  5 |        5 |        1 | NULL           | Willis	, Bicentennial

# |  6 |        6 |        1 | NULL           | Pfeiffer, Bicentennial
# |  7 |        6 |        2 | NULL           | Pfeiffer, The Party

# |  8 |        8 |        1 | NULL           | Hoffman , Bicentennial
# |  9 |        8 |        2 | NULL           | Hoffman , The Party
# | 10 |        8 |        3 | NULL           | Hoffman , Dr. Strangelove
# +----+----------+----------+----------------+
#
#
#
#
#  ActorList[TomHanks][MegRyan] = [JoeVsVolcano,YouVeGotMail,Sleepless]
# 		      [MegRyan] = [JoeVsVolcano,YouVeGotMail,Sleepless]
#
#        [(movie.name)JoeVsVolcano] = [MegRyan,Abe Vigoda]
#        [YouveGotMail] = [MegRyan]
#
#
#
#
#
#
#
#

require 'set'
class ActorMovieList
 def initialize(movie)
  @movie = movie
  @actors = []
 end
end


class ActorAppearList
  def initialize(actor)
    @actor     = actor
    @list1    = []           # movie.id, movie.name
    @duration = duration
  end
end


def find_all_actors_who_have_appeared_together_in_more_than_one_movie()
end

#
# 
#
#

def facc()
 for_each_actor__create_a_list_of_actors_who_appeared_with_them_in_more_than_one_movie()
end
#################################################
def for_each_actor__create_a_list_of_actors_who_appeared_with_them_in_more_than_one_movie

 puts
 apps = Appearance.find_all

 #
 
# list1 =  apps.sort_by {|i| i.actor_id}.sort_by {|i| i.movie_id}

 
 t = []  # listOfUniqueActorIds = []
 
 apps.each {|i| t.push(i.actor_id) }
 lu = t.to_set    # t = [1,1,1,4,5,6,6,8,8,8]
		  # lu = [1,4,5,6,8]
  
# list1.each {|i| 
#		  print "\n ActId,MovId :",i.actor_id,':',
#			Actor.find(i.actor_id).last_name,':',
#			i.movie_id,':',Movie.find(i.movie_id).name
# 		  
#            }

puts
end
# actor_appear[1] = [


class Song
  def initialize(name, artist, duration)
    @name     = name
    @artist   = artist
    @duration = duration
  end
end






