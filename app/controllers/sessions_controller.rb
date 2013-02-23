class SessionsController < ApplicationController

  def new
  	@title = "Sign In"
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or(user)
  	else
      flash.now[:error] = 'Invalid email/password combination'
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