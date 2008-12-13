#class List < ActiveRecord::Base
class List < Widget
  belongs_to :belonging
  has_many :items
end
