require 'mstram_backpack.rb'
###################################
puts
puts "'newbp' test"

###################
def lrem
 backpack = Newbp.new             # get connected
 reminders = backpack.listrem

 puts "=============================="
 puts "Reminders "
 puts reminders

 puts
 puts "TEST Creating a reminder : .."


# result = backpack.crem("A test reminder from the api",'2007-08-20 13:30:00')

 result = backpack.crem("A test reminder from the api",Time.now)
 print "\n\n result = '#{result}'\n "
end
###################################################################


#############################
#######
#######   pages
#######

def allpages
 backpack = Newbp.new             # get connected
 puts "all pages"

 result = backpack.allpages

 puts result
 puts
 puts
#  result.empty? ? true : {resa[0]=result ; resa[1]=raw ; resh[:result]=result ; resh[:raw]=raw}

 p_resh(result)
end

#######################################
###
### specific page
##

def gpage(page)
 backPackPage = backpack.getpage(page)
end


def getpage
 page = gpage(1196744)
 
backpack = Newbp.new             # get connected
 page = backpack.getpage(1151355)
 puts "============================================================================"
 puts "page = "
 puts page
 puts "============================================================================"
 p_resh(page)

 f=File.new('raw.txt','w')
 f.write(page[:raw])
 f.close

 f=File.new('result.txt','w')
 f.write(page[:result])
 f.close
 puts "created 'raw,txt', 'result.txt'"
end
########################

#curl -H 'X-POST_DATA_FORMAT: xml' -d '<request>
#  <token>40bd001563085fc35165329ea1ff5c5ecbdbbeef</token>
#</request>' \
#http://david.backpackit.com/ws/page/1

def h
 puts "================================="
 puts "bp1 Backpack tester"
 puts "-------------------"
 puts "tests available : "
 puts "lrem - List reminders"
 puts "allpages - get all pages"
 puts "gpage(page) - get a page"
 puts "getpage - get page '1196744'"
 puts
end
h