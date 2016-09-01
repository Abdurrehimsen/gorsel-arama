class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
    @photo = Photo.all
  end
  
  def keepdb(url,tags)
    @photo = Photo.create(url: url)

    for i in (0..(tags.length-1))
      tag = tags.keys[i].to_s
      if (Tag.find_by name: tag) == nil
        @tag = Tag.create(name: tag)
      else
        @tag = Tag.find_by name: tag
      end

      Possibility.create(poss:tags.values[i], tag: @tag, photo: @photo)

    end
  end

  def candidatelist
    arr = (Photo.all.to_a).select{|x| x.tags.first.name == @photo.tags.first.name or x.tags[1].name == @photo.tags.first.name}
  end

  def selector(a,key, value)
    b = a.to_a
    len = b.length
    elm = [key,value]
    if b.empty?
      b << elm
    elsif len<6 && len >0
      for i in 0..(len-1)
        if value >= b[i][1]
          b.insert(i,elm)
          break
        else
          b << elm
        end
      end
    else
      if value > b[len-1][1]
        for i in 0..(len-1)
          if value >= b[i][1]
            b.insert(i,elm)
            b.delete(b.last)          
            break
          end
        end   
      end
    end
  
    return b.to_h
  end

  def suggestions(sugphoto)
    sugphotags = {}
    for i in (0..((sugphoto.tags).length-1))
      sugphotags[sugphoto.tags[i].name] = sugphoto.possibilities[i].poss
    end

    point = 0

    @tags.each do |x,y|
      if sugphotags.has_key?(x.to_s)
        point += sugphotags[x.to_s] * y
      end
    end

    key = sugphoto.url.to_sym
    @sugglist.replace(selector(@sugglist,key,point))
      
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    python_output =  `python /home/abdurrehim/Desktop/Tarzara/app/tf_files/label_image.py #{@picture.name.url}`
    i = 0
    list = python_output.split(" ")
    respond = {}
    while i<=(list.length - 1)
      respond[list[i].to_sym] = list[i+1].to_f  
      i += 2
    end

    @sugglist = {}
    @tags = respond
    @url = @picture.name.url

    keepdb(@url,@tags)

    @array = [@tags, @url]

    candidatelist = candidatelist()
    candidatelist.each do |x|
      suggestions(x)
    end
    
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:name)
    end
end
