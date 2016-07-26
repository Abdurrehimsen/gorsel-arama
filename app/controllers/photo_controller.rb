class PhotoController < ApplicationController
  def index
  	result = Cloudinary::Uploader.upload('http://www.neguzelsozler.com/wp-content/uploads/2013/07/resimli-ask-sozleri.jpg')
  	@url = result["url"]
	@res2 = Clarifai::Rails::Detector.new(@url).image
  end
end
