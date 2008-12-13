class Belonging < ActiveRecord::Base
 belongs_to :page
 has_one :widget
end
