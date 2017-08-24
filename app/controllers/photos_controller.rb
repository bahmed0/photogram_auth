class PhotosController < ApplicationController
  
  # skip_before_action :authenticate_user!, :only => [:index, :show]    # whitelists those actions from the overarching authenticate_user command in application_controller
    
  def favorites
    @photos = current_user.liked_photos
    
    render("photos/favorites.html.erb")
  end
    
  def index
    @photos = Photo.all
    
  
    if current_user != nil 
      @user_id = current_user.id
    end
    
    @comments = Comment.all
    @comment = Comment.new
    
    @likes = Like.all
    @like = Like.new
    
    render("photos/index.html.erb")
  end

  def show
    @photo = Photo.find(params[:id])

    render("photos/show.html.erb")
  end

  def new
    @photo = Photo.new

    render("photos/new.html.erb")
  end

  def create
    @photo = Photo.new

    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.user_id = current_user.id      # By looking id up directly server side, protects against user passing another user's id in the params

    save_status = @photo.save

    if save_status == true
      redirect_to("/photos/#{@photo.id}", :notice => "Photo created successfully.")
    else
      render("photos/new.html.erb")
    end
  end

  def edit
    @photo = Photo.find(params[:id])

    render("photos/edit.html.erb")
  end

  def update
    @photo = Photo.find(params[:id])

    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.user_id = current_user.id

    save_status = @photo.save

    if save_status == true
      redirect_to("/photos/#{@photo.id}", :notice => "Photo updated successfully.")
    else
      render("photos/edit.html.erb")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    @photo.destroy

    if URI(request.referer).path == "/photos/#{@photo.id}"
      redirect_to("/", :notice => "Photo deleted.")
    else
      redirect_to(:back, :notice => "Photo deleted.")
    end
  end
end
