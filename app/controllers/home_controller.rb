class HomeController < ApplicationController
  def index
	result = Cloudinary::Uploader.upload('http://www.neguzelsozler.com/wp-content/uploads/2013/07/resimli-ask-sozleri.jpg')
  	@url = result["url"]
	@res2 = Clarifai::Rails::Detector.new(@url).image
	
	@tags = @res2.tags
	@url = @res2.url
	@docid = @res2.docid
  end
end
