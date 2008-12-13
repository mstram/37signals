#class Note < ActiveRecord::Base
class Note < Widget
  belongs_to :belonging
end
