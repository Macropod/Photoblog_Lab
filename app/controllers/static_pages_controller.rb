class StaticPagesController < ApplicationController
  def home
    @posts = Post.paginate(page: params[:page], :per_page => 20)
    @galleries = galleries(current_user)
    if !params[:page].nil?
      @page = params[:page]
    else
      @page = 0
    end
  end

  # def help
  # 	@title = "Help"
  # end

  # def about
  # 	@title = "About"
  # end

  # def contact
  # 	@title = "Contact"
  # end
end
