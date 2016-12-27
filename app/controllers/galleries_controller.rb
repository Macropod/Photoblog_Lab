class GalleriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,      only: [:new, :create, :edit, :update, :destroy, :index]

  def new
    @gallery = Gallery.new
    @title = "New Gallery"
  end

  def show
    @posts = Post.where(:gallery_id => params[:id]).paginate(page: params[:page], :per_page => 20)
    @galleries = galleries(current_user)
    @gallery_id = params[:id]
    if !params[:page].nil?
      @page = params[:page]
    else
      @page = 0
    end
  end

  def index
    @title = "Galleries Overview"
    @galleries = galleries(current_user)
  end

  def create
    #@gallery = Gallery.new(params[:gallery])
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      flash[:success] = "Gallery created!"
      redirect_to root_url
    else
      flash[:error] = "Gallery was not created successfully!"
      redirect_to root_url
    end
  end

  def edit
    @gallery = Gallery.find_by_id(params[:id])
    @title = "Update Gallery"
  end

  def update
    @gallery = Gallery.find_by_id(params[:id])
    if @gallery.update_attributes(params[:gallery])
      flash[:success] = "Gallery updated"
      redirect_to galleries_path
    else
      render 'edit'
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

  private

  def gallery_params
    params.require(:gallery).permit(:name, :start_date, :end_date)
  end

end