module Debug
  def whoAmI?
   puts "\nclass name = '#{self.class.name}' \n id=(#{self.object_id}):\n to_s =  #{self.to_s}\n  inspect = '#{self.inspect}'\n"
  end
end

module Old
 class Phonograph
   include Debug
   attr_reader :name

  def initialize(name)
    @name = name
    @tracks = []
    puts "Phonograph:initialize I am a Phonograph"
  end

  def tracks
   @tracks.each {|s| puts s}
  end

  def track=(name)
   @tracks.push(name)
   puts "added track '#{name}'"
  end

 end  # class Phonograph

 class EightTrack
  include Debug
  attr_reader :name

  def initialize(name)
    @name = name
    puts "EightTrack:initialize I am an EightTrack"
  end
 end

  ph = Phonograph.new("West End Blues")
  et = EightTrack.new("Surrealistic Pillow")

  ph.whoAmI?
  # » "Phonograph (#537762134): West End Blues"
  et.whoAmI?

  def getph
    ph
   end

end  #module Old

thing = "glok"

def gething
 thing
end

#» "EightTrack (#537761824): Surrealistic Pillow"
