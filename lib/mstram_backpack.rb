require 'backpack_lib.rb'
#####################################################
class Newbp
  @debug = false

  attr_reader :bp
  
  def initialize
   token = "2cd7fead9448ecc584981090345a360d160b914f"
   @bp= Backpack.new('mstram',token)
  end

   def debug_sep
     20.times do print "\n ...................." end
   end
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
