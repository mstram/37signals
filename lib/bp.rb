#  Requires that XmlSimple is already loaded, like it is from within script/console in the latest beta Rails
# Author: David Heinemeier Hansson, 37signals

require 'yaml'
require 'net/https'
require 'pp'

class Backpack
  attr_accessor :username, :token, :current_page_id

  def initialize(username, token)
    @username, @token = username, token
    connect
  end

  def connect(use_ssl = false)
 #   @connection = Net::HTTP.new("#{@username}.backpackit.com", use_ssl ? 443 : 80)
   @connection = Net::HTTP.new("localhost", use_ssl ? 443 : 80)

    @connection.use_ssl = use_ssl
    @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE if use_ssl
  end

  def page_id=(id)
    self.current_page_id = id
  end
  alias :pi= :page_id=

  def request(path, parameters = {}, second_try = false)
    parameters = { "token" => @token }.merge(parameters)

    puts "Backpack.request: path = '#{path}'"
    #exit
    #response = @connection.post("/ws/#{path}", parameters.to_yaml, "X-POST_DATA_FORMAT" => "yaml")
    response = @connection.post("/#{path}", parameters.to_yaml, "X-POST_DATA_FORMAT" => "yaml")

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
    #request "reminders"
    request "products"
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
   puts "Newbp: @bp = '#{@bp}'"
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
#     def allpages
     def pages
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
####################

 #backpack = Newbp.new             # get connected
 $bp  = Newbp.new             # get connected
 $bp.pages

# reminders = backpack.listrem
# reminders = $bp.listrem

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

#backpack = Newbp.new             # get connected
#puts "all pages"

#result = backpack.allpages

#puts result
#puts
#puts
# result.empty? ? true : {resa[0]=result ; resa[1]=raw ; resh[:result]=result ; resh[:raw]=raw}

#p_resh(result)

#######################################
###
### specific page
###
#page = backpack.getpage(1196744)

#backpack = Newbp.new             # get connected

#page = backpack.getpage(1151355)
#puts "============================================================================"
#puts "page = "
#puts page
#puts "============================================================================"
#p_resh(page)

#f=File.new('raw.txt','w')
#f.write(page[:raw])
#f.close

#f=File.new('result.txt','w')
#f.write(page[:result])
#f.close
#puts "created 'raw,txt', 'result.txt'"

#curl -H 'X-POST_DATA_FORMAT: xml' -d '<request>
#  <token>40bd001563085fc35165329ea1ff5c5ecbdbbeef</token>
#</request>' \
#http://david.backpackit.com/ws/page/1


