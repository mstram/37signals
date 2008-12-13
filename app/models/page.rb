class Page < ActiveRecord::Base
 has_many   :belongings
 belongs_to :bpack
end
