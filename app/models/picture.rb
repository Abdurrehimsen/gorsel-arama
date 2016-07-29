class Picture < ActiveRecord::Base
	mount_uploader :name, PictureUploader
end
