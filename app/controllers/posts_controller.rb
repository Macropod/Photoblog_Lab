class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,      except: [:index]

  def new
  	@title = "New post"
  	@post = current_user.posts.build
    @galleries = Gallery.all
  end

  def index
    @title = "Posts Overview"
    @posts = Post.paginate(page: params[:page], :per_page => 20)
    @galleries = galleries(current_user)
    if !params[:page].nil?
      @page = params[:page]
    else
      @page = 0
    end
  end


  def edit
    @post = Post.find_by_id(params[:id])
    @title = "Update Post"
    @galleries = Gallery.all
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated"
      redirect_to posts_path
    else
      render 'edit'
    end
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