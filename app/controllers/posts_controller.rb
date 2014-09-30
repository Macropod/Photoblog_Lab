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
    # reorder gets rid of the default scope here and allows us to ignore the sort_index for the posts overview page, which makes it possible to reuse the same range of sort_indices for different galleries
    @posts = Post.reorder('created_at DESC').paginate(page: params[:page], :per_page => 20)     
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
    image_parameters = params[:post][:text].split("\t")
    @post = Post.find_by_id(params[:id])

    if params[:images].nil?
      success = @post.update_attributes(gallery_id: params[:post][:gallery_id], text: image_parameters[0], sort_index: image_parameters[1], family: image_parameters[2], friends: image_parameters[3], others: image_parameters[4])
    else
      success = @post.update_attributes(picture: params[:images], gallery_id: params[:post][:gallery_id], text: image_parameters[0], sort_index: image_parameters[1], family: image_parameters[2], friends: image_parameters[3], others: image_parameters[4])
    end

    if success
      flash[:success] = "Post updated"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def create
    all_image_parameters = params[:post][:text].split("\n")
    params[:images].each_with_index{ |image, index|
      image_parameters = all_image_parameters[index].split("\t")
      @post = current_user.posts.build(picture: image, gallery_id: params[:post][:gallery_id], text: image_parameters[0], sort_index: image_parameters[1], family: image_parameters[2], friends: image_parameters[3], others: image_parameters[4])
      if @post.save
        flash[:success] = "Post created!"
      else
        @title = "New post"
        @galleries = Gallery.all
        #render 'posts/new'
      end
    }
    redirect_to root_url
    #@post = current_user.posts.build(params[:post])
    # if @post.save
    #   flash[:success] = "Post created!"
    #   redirect_to root_url
    # else
    #   @title = "New post"
    #   @galleries = Gallery.all
    #   render 'posts/new'
    # end
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