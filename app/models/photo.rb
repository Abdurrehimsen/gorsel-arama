class Photo < ActiveRecord::Base
	has_many :possibilities
	has_many :tags, through: :possibilities

	mount_uploader :attr, PictureUploader
end
