class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:destroy]

  def create
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    if params[:page] == "0"
      page = nil
      @page = 0
    else
      page = params[:page]
      @page = page
    end
    if params[:gallery_id] == ""
      @posts = Post.all.paginate(page: page)
    else
      @posts = Post.where(:gallery_id => params[:gallery_id]).paginate(page: page)
    end
    @galleries = Gallery.all
    @gallery_id = params[:gallery_id]
    #render :inline => "<%= debug(params) if Rails.env.development? %>"
    if @comment.save
      flash[:success] = "Comment created!"
      render "galleries/show"
    else
      flash[:error] = "Comment could not be created. Did you forget your name?"
      render "galleries/show"
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