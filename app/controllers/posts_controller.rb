class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user

  def new
  	@title = "New post"
  	@post = current_user.posts.build
  end

  def create
  	@post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'posts/new'
    end
  end

  def destroy
  	@post = Post.find_by_id(params[:id])
  	if @post.nil?
  		flash[:error] = "Post not found!"
  		redirect_to root_url
  	else
	  	@post.destroy
	  	flash[:success] = "Post deleted!"
	  	redirect_to root_url
	  end
  end
end