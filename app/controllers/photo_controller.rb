class PhotoController < ApplicationController
  def index
  	post.update_attributes(params[:post])
  end
end
