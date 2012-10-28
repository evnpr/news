class News < ActiveRecord::Base
    has_many :pros
    has_many :conss
end
