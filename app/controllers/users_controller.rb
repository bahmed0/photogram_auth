class UsersController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]
  
  def index
    @users = User.all

    render("users/index.html.erb")
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.photos

    render("users/show.html.erb")
  end

end

