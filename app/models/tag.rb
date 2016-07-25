class Tag < ActiveRecord::Base
	has_many :possibilities
	has_many :photos, through: :possibilities
end
