class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:destroy]

  def create
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to root_url
      #render 'static_pages/home'
    else
      flash[:error] = "Comment could not be created!"
      redirect_to root_url
      #render 'static_pages/home'
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      flash[:error] = "Post not found!"
      redirect_to root_url
    else
      @comment.destroy
      flash[:success] = "Post deleted!"
      redirect_to root_url
    end
  end

end