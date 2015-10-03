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
    @galleries = galleries(current_user)
    @gallery_id = params[:gallery_id]
    #render :inline => "<%= debug(params) if Rails.env.development? %>"
    if @comment.save
      flash[:success] = "Comment created!"
      # render "galleries/show"
      redirect_back_or(root_path)
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

  def index
    if not(params.has_key?(:page))
      page = nil
      @page = 0
    elsif params[:page] == "0" 
      page = nil
      @page = 0
    else
      page = params[:page]
      @page = page
    end
    comments_non_unique = Comment.select("DISTINCT(post_id), *").order("post_id").order("created_at DESC")

    store_location

    @comments ||= Array.new
    post_ids ||= Array.new
    comments_non_unique.each do |comment|
      if post_ids.include? comment.post_id
      else
        @comments.push(comment)
        post_ids.push(comment.post_id)
      end
    end
    @comments = @comments.paginate(page: params[:page], :per_page => 5)
    @galleries = galleries(current_user)
  end
end