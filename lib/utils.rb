#
# print actor names for a movie
#
  puts "--------------------"
  puts "utils.rb loaded "
  puts "--------------------"

def h()
 uh()
end

def uh()
  puts " nm(movie_name)         -  add a movie  "
  puts " ac(lname,fname)  	-  add an actor "
  puts " fmm()			-  find movies wiht multiple actors"
  puts " fm0()			-       movies with 0 actors"
  puts " pn(movie)   	- print actor's names in a movie"
# puts " print_kids(thing,what)"

  puts " fwl(lname) 	        -  find an actor by last name (wildcard)"
  puts " fwm(movie_name)	-  find a movie by wildcard name"
  puts " pnl(list_of_actors)    -  print actor's names from a list of actors"
  puts " afc(cond)		-  find an actor by condition"
end
###########
 def pmov(movies)
 movies.each {|m| pn(m) }
 puts
 end
###########

  def nm(name)
    Movie.create(:name => name)
  end
#################################################3
  def ac(lname,fname)
     Actor.create(:last_name => lname, :first_name => fname)
  end
#################################################3
#
# find movies with 2 or more actors attached
#
  def fmm(wantData)
   puts "Movies with multiple actors"
   ar = []
   Movie.find_all.each {|mm| 
			if mm.actors.count > 1 then 
			   print "\n",mm.id,' ',mm.name,' ',mm.actors.count 
			   ar.push(mm)
			end
		     }
  puts
   if wantData
    return ar
   end
 end
#################################
 def fm0(wantData)
   puts "Movies with 0 actors "
   ar = []
   Movie.find_all.each {|mm| 
			if mm.actors.count == 0 then 
			   print "\n",mm.id,' ',mm.name,' ',mm.actors.count 
   			   ar.push(mm)
			end
		     }
  puts
   if wantData
    return ar
   end
 end

######################################################
#//////////////////////////
###############################################################
  def pnold(movie_id)
   m = Movie.find(movie_id)
   print "\n","Actors for the Movie - ",m.name
   print "\n ==================================="
    m.actors.each {|a| print "\n",a.first_name,' ',a.last_name  }
   puts
  end

###########################################################3
  def mm(movieList)
   print "\n ==================================="
    movieList.each {|a| print "\n(",a.id,")",a.name,"  ",a.date}
   puts
  end

###########################################################3
  def pn(movie)
#   if movie.class == Array then
#    puts "pn: got array .. redirecting to 'pmov'"
#    pmov(movie)
#    return
#   end

   print "\n","(",movie.id,")",movie.name,"  ",movie.date
   print "\n ==================================="
    movie.actors.each {|a| print "\n",a.id,':',a.first_name,' ',a.last_name  }
   puts
  end
###########################################################3
  def print_kids(thing,what)
   print "\n","Actors for the Movie - ",movie.name
   print "\n ==================================="
    movie.actors.each {|a| print "\n",a.first_name,' ',a.last_name  }
   puts
  end
###########################################################
def foo()
 puts "========"
 puts "foo"
 puts "========"
end

  def fwla(lname)
   puts "fwl1 v 0.01"
#   t=Actor.find(:all, :conditions => ["last_name LIKE %?%",lname] )
   t=Actor.find(:all, :conditions => ["last_name LIKE '?' ",lname] )
#   t=Actor.find(:all, :conditions => ["last_name LIKE '?' ",lname] )
   if t.length ==1 then 
    t=t[0]
   end
    return t
  end
#e': ./script/../config/../config/../lib/utils.rb:115: parse error, unexpecte
#d ')', expecting tASSOC (SyntaxError)

###########################################################
  def fwl(lname)
   t=Actor.find(:all, :conditions => "last_name LIKE '%" + lname + "%' ")
   if t.size == 1 then 
    t=t[0]

#   if t.is_a? Actor then 
#     t=t.fullname
#     else
#     t=t.collect(&:fullname) 

   end
    return t
  end
###########################################################3
  def fwm(movie_name)
   t=Movie.find(:all, :conditions => "name LIKE '%" + movie_name + "%'")
   if t.length == 1 then 
     t=t[0]
   end
  return t
 end
###########################################################3

####
####   print last_name, and list of movies for each actor(s) in a list
####

####
####   e.g.   actors = Actor.find(:all, :conditions => "stprov = 'CA' ")
####          pnl(actors)
#####
#####              

 def pnl(list_of_actors)
 puts
 list_of_actors.each {|i| puts i.last_name}

# 			i.movies.each {|m| 
#				print "==",m.name,' : '
#				       }
#                     }
 puts
end

################3
#
#      afc("stprov = 'CA'")
#

 def afc(cond)
   Actor.find(:all, :conditions => cond)
 end

########3
def facc()
 find_actors_who_appeared_together()
end

# def find_actors_who_appeared_together()

 puts
# apps = Appearance.find_all
# test = []
 #
 
# test.push(apps[0..4]) 
# test=test[0]
# t = []
# actor_t = t  test.sort_by {|i| i.actor_id}
 
# t.each {|i| print "\n",i.actor_id,' ',i.movie_id}

#puts
#end

def lfwac(*actors)
  return [] if actors.empty?
  actors = actors.flatten
  Actor.find(:all, :readonly => false,
       :joins => "INNER JOIN appearances a ON movies.id = a.movie_id",
       :conditions => "a.actor_id IN ( #{actors.map(&:id).join(', ')} )",
       :group => "movies.id HAVING COUNT(movies.id) = #{actors.size}")
end

def fwac2(*actors)
  return [] if actors.empty?
  actors = actors.flatten
  Movie.find(:all, :readonly => false,
       :joins => "INNER JOIN appearances a ON movies.id = a.movie_id",
       :conditions => "a.actor_id IN ( #{actors.map(&:id).join(', ')} )",
       :group => "movies.id HAVING COUNT(movies.id) = #{actors.size}")
end

