class SessionsController < ApplicationController

  def new
  	@title = "Sign In"
  end

  def create
  	user = User.find_by_name(params[:session][:name])
  	if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or(root_path)
  	else
      flash.now[:error] = "Invalid name/password combination"
      @title = "Sign In"
      render 'new'
  	end
  end

  def destroy
    sign_out
    flash[:success] = 'You have been successfully logged off'
    redirect_to root_url
  end

end
