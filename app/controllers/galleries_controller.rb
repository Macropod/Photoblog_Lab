class GalleriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,      only: [:new, :create, :destroy]

  def new
    @gallery = Gallery.new
    @title = "New Gallery"
  end

  def show
    @posts = Post.where(:gallery_id => params[:id]).paginate(page: params[:page])
    @galleries = Gallery.all
    @gallery_id = params[:id]
    if !params[:page].nil?
      @page = params[:page]
    else
      @page = 0
    end
  end

  def create
     @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      flash[:success] = "Gallery created!"
      redirect_to root_url
    else
      flash[:error] = "Gallery was not created successfully!"
      redirect_to root_url
    end
  end

  def destroy
    @gallery = Gallery.find_by_id(params[:id])
    if @gallery.nil?
      flash[:error] = "Gallery not found!"
      redirect_to root_url
    else
      @gallery.destroy
      flash[:success] = "Gallery deleted!"
      redirect_to root_url
    end
  end

end