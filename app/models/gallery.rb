#class Gallery < ActiveRecord::Base
class Gallery  < Widget
 belongs_to :belonging
# has_many :images
end
