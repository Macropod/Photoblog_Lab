class StaticPagesController < ApplicationController
  def home
    # @posts = []
    # User.all.each do |user|
    #   if user.posts
    #     @posts = @posts.concat(user.posts)
    #   end
    # end
    # @posts = @posts.paginate(page: params[:page])
    @posts = Post.paginate(page: params[:page])
    @galleries = Gallery.all
  end

  def help
  	@title = "Help"
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact"
  end
end
