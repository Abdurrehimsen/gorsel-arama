class Photo < ActiveRecord::Base
	has_many :possibilities
	has_many :tags, through: :possibilities
end
