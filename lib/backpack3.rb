# <response success="true">
#<page title="Actors" id="1196736" email_address="kuruge46@mstram.backpackit.com">
#
#  <belongings>
#   <belonging id="3390427">
#   <position>1</position>
#    <widget type="Note" id="2293987"/>
#   </belonging>
#
#   <belonging id="3390355"><position>2
#    </position>
#    <widget type="List" id="1191609"/>
#    </belonging>
#
#   <belonging id="3390352">
#    <position>3</position>
#     <widget type="List" id="1191608"/>
#    </belonging>
#
#   <belonging id="3390348">
#    <position>4</position>
#     <widget type="List" id="1191607"/>
#    </belonging>
#   </belongings>
#
#  <tags>
#   <tag name="actors" id="101778"/>
#   <tag name="movies" id="101779"/>
#   <tag name="fun" id="101780"/>
#   </tags>
#
#  <lists>
#   <list name="Jim Carey" id="1191607">
#    <items>
#      <item completed="false" id="11408746" list_id="1191607">Eternal Sunshine of the Spotless Mind</item>
#      <item completed="false" id="11408747" list_id="1191607">Caddie Shack</item></items></list><list name="Tom Hanks" id="1191608"><items>
#      <item completed="false" id="11408763" list_id="1191608">Big</item>
#    </items>
#   </list>
#
#   <list name="John Travolta" id="1191609">
#    <items>
#     <item completed="false" id="11408777" list_id="1191609">Swordfish</item>
#     <item completed="false" id="11408780" list_id="1191609">Michael</item>
#    </items>
#   </list>
#  </lists>
#
#   <notes>
#   <note title="A note" id="2293987" created_at="2007-08-12 07:09:20">stuff in the note</note>
#   </notes>
#
#</page>
#</response>

require 'yaml'
require 'net/https'
require 'pp'

class Backpack
  attr_accessor :username, :token, :current_page_id, :current_list_id

  def initialize(username, token)
    @username, @token = username, token
    connect
   print "\ninitialize: @connection = #{@connection}\n"
   print "\n @connection = '#{@connection.class}\n"
  end

  def connect(use_ssl = false)
    @connection = Net::HTTP.new("#{@username}.backpackit.com", use_ssl ? 443 : 80)
    @connection.use_ssl = use_ssl
    @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE if use_ssl
  end

  def page_id=(id)
    self.current_page_id = id
  end

  def list_id=(id)
    self.current_list_id = id
  end

  alias :pi= :page_id=

  def request(path, parameters = {}, second_try = false)
    parameters = { "token" => @token }.merge(parameters)

    response = @connection.post("/ws/#{path}", parameters.to_yaml, "X-POST_DATA_FORMAT" => "yaml")

    if response.code == "200"
      # mike
      raw = response.body
      #20.times do print "\n ...................." end
      #puts "raw XML = "
      #puts raw
      #20.times do print "\n ...................." end
      #
      result = XmlSimple.xml_in(response.body)
      #10.times do print "\n -------------------" end
      #
      # result is a - hash -
      #
      # print "result = #{result}\n result.class = #{result.class}\n"
      result.delete "success"

      #
      # mike
      #
      resa = []
      resh = {}
      #result.empty? ? true : result
#      result.empty? ? true : (  resa[0]=result ;resa[1]=raw )

      result.empty? ? true : (resh[:result]=result;resh[:raw]=raw)
      resh

    elsif response.code == "302" && !second_try
      connect(true)
      request(path, parameters, true)
    else
      raise "Error occured (#{response.code}): #{response.body}"
    end
  end
  alias :r :request

  # lists

#  Add a new list to the page.
#  POST /ws/page/#{page_id}/lists/add

  def add_list(name,page_id = current_page_id)
   request "page/#{page_id}/lists/add","name" => name
  end

  #########################################################################3333

#  curl -H 'X-POST_DATA_FORMAT: xml' -d '<request>
#  <token>2cd7fead9448ecc584981090345a360d160b914f</token>
# </request>' \
# http://mstram.backpackit.com/ws/page/1196736/lists/1191608/items/list

  def list_items_list(page_id = current_page_id, list_id = current_list_id)
   request "page/#{page_id}/lists/#{list_id}/items/list"
  end

   # all lists

#   POST /ws/page/#{page_id}/lists/list

   def list_lists(page_id = current_page_id)
   #  POST /ws/page/#{page_id}/lists/list
     request "page/#{page_id}/lists/list"
   end

###########################################################################################
#   curl -H 'X-POST_DATA_FORMAT: xml' -d '<request>
#  <token>2cd7fead9448ecc584981090345a360d160b914f</token>
#  <item><content>The Davinci Code</content></item>
# </request>' \
# http://mstram.backpackit.com/ws/page/1196736/lists/1191608/items/add


   def add_list_item(content,page_id = current_page_id, list_id = current_list_id)
       # POST /ws/page/#{page_id}/lists/#{list_id}/items/add
     request "page/#{page_id}/lists/#{list_id}/items/add", "item" => { "content" => content }
   end

##########################################################################################

  # Items ----

  def list_items(page_id = current_page_id)
    request "page/#{page_id}/items/list"
  end
  alias :li :list_items

  def create_item(content, page_id = current_page_id)
     request "page/#{page_id}/items/add", "item" => { "content" => content }
  end
  alias :ci :create_item

  def update_item(item_id, content, page_id = current_page_id)
    request "page/#{page_id}/items/update/#{item_id}", "item" => { "content" => content }
  end
  alias :ui :update_item

  def destroy_item(item_id, page_id = current_page_id)
    request "page/#{page_id}/items/destroy/#{item_id}"
  end
  alias :di :destroy_item

  def toggle_item(item_id, page_id = current_page_id)
    request "page/#{page_id}/items/toggle/#{item_id}"
  end
  alias :ti :toggle_item

  def move_item(item_id, direction, page_id = current_page_id)
    request "page/#{page_id}/items/move/#{item_id}", "direction" => "move_#{direction}"
  end
  alias :mi :move_item


  # Notes ----

  def list_notes(page_id = current_page_id)
    request "page/#{page_id}/notes/list"
  end
  alias :li :list_notes

  def create_note(title, body, page_id = current_page_id)
    request "page/#{page_id}/notes/create", "note" => { "title" => title, "body" => body }
  end
  alias :cn :create_note

  def update_note(note_id, title, body, page_id = current_page_id)
    request "page/#{page_id}/notes/update/#{note_id}", "note" => { "title" => title, "body" => body }
  end
  alias :un :update_note

  def destroy_note(note_id, page_id = current_page_id)
    request "page/#{page_id}/notes/destroy/#{note_id}"
  end
  alias :dn :destroy_note


  # Emails ----

  def list_emails(page_id = current_page_id)
    request "page/#{page_id}/emails/list"
  end
  alias :le :list_emails

  def show_email(email_id, page_id = current_page_id)
    request "page/#{page_id}/emails/show/#{email_id}"
  end
  alias :se :show_email

  def destroy_email(email_id, page_id = current_page_id)
    request "page/#{page_id}/emails/destroy/#{email_id}"
  end
  alias :de :destroy_email

  # Tags ----

  def list_pages_with_tag(tag_id)
    request "tags/select/#{tag_id}"
  end
  alias :lpt :list_pages_with_tag

  def tag_page(tags, page_id = current_page_id)
    request "page/#{page_id}/tags/tag", "tags" => tags
  end
  alias :tp :tag_page

  # Pages ----

  def list_pages
    request "pages/all"
  end
  alias :lp :list_pages

  def create_page(title, body)
    request "pages/new", "page" => { "title" => title, "description" => body }
  end
  alias :cp :create_page

  def show_page(page_id = current_page_id)
    self.page_id=(page_id)
    request "page/#{page_id}"
  end
  alias :sp :show_page

  def destroy_page(page_id = current_page_id)
    request "page/#{page_id}/destroy"
  end
  alias :dp :destroy_page

  def update_title(title, page_id = current_page_id)
    request "page/#{page_id}/update_title", "page" => { "title" => title }
  end
  alias :ut :update_title

  def update_body(body, page_id = current_page_id)
    request "page/#{page_id}/update_body", "page" => { "description" => body }
  end
  alias :ub :update_body

  def link_page(linked_page_id, page_id = current_page_id)
    request "page/#{page_id}/link", "linked_page_id" => linked_page_id
  end
  alias :lip :link_page

  def unlink_page(linked_page_id, page_id = current_page_id)
    request "page/#{page_id}/unlink", "linked_page_id" => linked_page_id
  end
  alias :ulip :unlink_page

  def share_page(email_addresses, public_page = nil, page_id = current_page_id)
    parameters = { "email_addresses" => email_addresses }
    parameters = parameters.merge({ "page" => { "public" => public_page ? "1" : "0" }}) unless public_page.nil?
    request "page/#{page_id}/share", parameters
  end

  # Reminders ---

  def list_reminders
    request "reminders"
  end
  alias :lr :list_reminders

  def create_reminder(content, remind_at = "")
    request "reminders/create", "reminder" => { "content" => content, "remind_at" => remind_at }
  end
  alias :cr :create_reminder

  def update_reminder(reminder_id, content, remind_at)
    request "reminders/update/#{reminder_id}", "reminder" => { "content" => content, "remind_at" => remind_at }
  end
  alias :ur :update_reminder

  def destroy_reminder(reminder_id)
    request "reminders/destroy/#{reminder_id}"
  end
  alias :dr :destroy_reminder
end

###########################33

#class Backpack
#  attr_accessor :username, :token, :current_page_id

#  def initialize(username, token)

#####################################################
class Newbp
  @debug = false

  def initialize
   token = "2cd7fead9448ecc584981090345a360d160b914f"
   @bp= Backpack.new('mstram',token)
  end

   def debug_sep
     20.times do print "\n ...................." end
   end
  #
  # pages
  #

   #
   #  all pages
   #
     def allpages
      @result = @bp.list_pages

      if @debug
       debug_sep()
       print "\n allpages \n\n"
       print "\n allpages : result = '#{@result}'\n"
      end
      @result
     end

  #
  #  specific page
  #

   def getpage(page)
      @result = @bp.show_page(page)

    if @debug
      debug_sep()
      print "\n\n getpage '#{page}' \n\n\n\n" if @debug == 1
      debug_sep()
      puts @result
     end
    @result
   end

  #
  # reminders
  #

  def listrem
    @reminders = @bp.list_reminders
    if @debug
     puts "reminders = "
     puts @reminders
    end
    @reminders
  end

  def crem(content,whenat)
    @result = @bp.create_reminder(content,whenat)
   if @debug
    print "\n\n Creating a reminder ...\n"
    print "\n\n result = #{@result} "
   end
   @result
  end

#  def add_list_item(list,item)
#  # POST /ws/page/#{page_id}/lists/#{list_id}/items/add

#   @bp.create_item('item completed="false"

#  end

   def get_lists
     puts "========================================================="
     puts " Lists "
    @bp.list_lists
   end

end
####################################################
def p_resh(resh)
 puts "-----------------------------------------------------------------------------"
 puts "p_resh: resh "
 pp resh
 puts
 puts
 puts "resh[:result] "
 pp resh[:result]
 puts
 puts
 puts "resh[:raw] "
 puts
 puts  resh[:raw]
end

def p_resa(resa)
 puts "-----------------------------------------------------------------------------"
 puts " resa "
 pp resa
 puts
 puts
 puts "resa[0] (result)"
 pp resa[0]
 puts
 puts
 puts "resa[1] (raw)"
 puts
 puts  resa[1]
end

###################################
puts
puts "'newbp' test"

########################

###################################
####################333

# backpack = Newbp.new             # get connected
# reminders = backpack.listrem

# puts "=============================="
# puts "Reminders "
# puts reminders

# puts
# puts "TEST Creating a reminder : .."

# result = backpack.crem("A test reminder from the api",'2007-08-20 13:30:00')

# print "\n\n result = '#{result}'\n "
###################################################################


#############################33
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
 # result.empty? ? true : {resa[0]=result ; resa[1]=raw ; resh[:result]=result ; resh[:raw]=raw}

 p_resh(result)
 result
end

#######################################
###
### specific page
###
#page = backpack.getpage(1196744)

def getpage(page)
 backpack = Newbp.new             # get connected
 page = backpack.getpage(page)
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
puts "================================================================================="

def lists
 backpack = Newbp.new             # get connected
 backpack.get_lists
end

#allpages()

def token
  "2cd7fead9448ecc584981090345a360d160b914f"
end

#lists

#getpage(1151355)
#getpage(1197630) #alltypes

def moviePage
 1197628
end

def actors
1196736
end

def getactors
getpage(actors) #Actors
end

def getmovies
getpage(moviePage) #Movies
end



def hanks
 1191608
end

# addListItem('id="11408746" list_id="1191607">Eternal Sunshine of the Spotless Mind</item>

#def add_list_item(page_id = current_page_id,list_id=current_list_id,content)


# Create
# POST /ws/page/#{page_id}/lists/#{list_id}/items/add

def bpn
   token = "2cd7fead9448ecc584981090345a360d160b914f"
   @bp = Backpack.new('mstram',token)
end

# 'The Whole Nine Yards'

def add1
 bp = bpn
 bp.add_list_item('Apollo13',actors,hanks)
end

def addListItem(item,page,list)
 bp = bpn
 bp.add_list_item(item,page,list)
end

def listhanks
 bp = bpn
 bp.list_items_list(actors,hanks)
end

def addlist(name,page)
 bp = bpn
 bpn.add_list(name,page)
end

# add1
# listhanks
# addlist('Paul Newman',actors)

def addActor(actorName)
 hash1 = {}
 hash1[:result_raw_hash] = addlist(actorName,actors)
 hash1[actorID]=h[:result_raw_hash][:result]['list'][0]['id']
 hash1[actorName]=h[:result_raw_hash][:result]['list'][0]['name']
 print "\n h[0] = #{h[0]}  h[1] = #{h[1]} \n\n"
 hash1
end

#addActor('Bruce Willis')

def AmandaPeet
1191767
end

def cheadle
1191777
end

##########################################
def toy
 actors = []
 actors.push('Tom Hanks : Woody')
 actors.push('Tim Allen : Buzz')
 actors.push('Don Rickles : Mr. Potato Head')
 actors.push('Jim Varney : Slinky Dog')
 actors.push('Wallace Shawn : Rex')
 actors.push('John Ratzenberger : Hamm')
 actors.push('Annie Potts : Bo Peep')
 actors.push('R. Lee Ermey : Sergeant')
 actors.push('John Morris : Andy')
 actors.push('Sarah Freeman : Hannah')
 actors.push('Erik von Detten : Sid')

 print "\n adding movie 'Toy Story' \n"
 h = addlist('Toy Story',moviePage)
 puts h
 movie = h[:result]['list'][0]['id']
 print "\n\n movie = #{movie} \n\n"

 print "\n Adding actors ....\n"

 actors.each {|actor|
              print "\n #{actor}"
              addListItem(actor,moviePage,movie)
             }
 print "\n\n Done"
end
##########################################
def m1
 moviePage = '1197628'
 puts
 puts "Adding Movies from local database"
 movs=Movie.find(:all)
 movs.each {|m| s = m.name + " : " + m.date.to_s
                print "\n #{s} "
                addlist(s,moviePage)
           }
 puts
 puts
end