class Backpack
 print "\n dummy Backpack class"

  def list_reminders
   puts "dummy 'list_reminders' method"
  end

 #def  create_reminder(content,when)
 # puts "dummy 'create_reminder' "
 #end

end
#####################################3
class Newbp
  def initialize
   token = "2cd7fead9448ecc584981090345a360d160b914f"
 #  @bp= Backpack.new('mstram',token)
  end

  def listrem
    @reminders = @bp.list_reminders
    puts "reminders = "
    puts @reminders
    @reminders
  end

  def hi
   puts "hello there"
  end

  def crem(content,whenat)
#   print "\n\n Creating a reminder ...\n "
   @result = @bp.create_reminder(content,whenat)
#   print "\n\n result = #{@result} "
#   @result
  end

end