class UsersController < ApplicationController
  #before_filter :signed_in_user,  only: [:index, :edit, :update]
  #before_filter :correct_user,    only: [:edit, :update]
  #before_filter :not_signed_in,   only: [:new, :create]
  before_filter :admin_user,      only: [:new, :create, :index, :edit, :update, :destroy, :show]

  def new
  	@user = User.new
    @title = "Sign Up"
  end

  def create
  	 @user = User.new(params[:user])
    if @user.save
      #sign_in @user
      flash[:success] = "Welcome to the PhotoBlog!"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user != current_user
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    else
      redirect_to root_path
    end
  end

  def show
  	@user = User.find(params[:id])
    @title = @user.name
  end

  def index
    @title = "All users"
    @users = User.paginate(page: params[:page])
  end

  def edit
    @title = @user.name
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      #sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url, notice: "You have no access to this page." unless current_user?(@user) 
    end

    def not_signed_in
      redirect_to(root_path) unless !current_user
    end

end
