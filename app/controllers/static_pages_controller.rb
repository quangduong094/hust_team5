class StaticPagesController < ApplicationController
  def home
    @image = current_user.images.build if logged_in?
  	#@feed_items = current_user.feed.paginate(page: params[:page], per_page: 20)
  	@feed_items = Image.paginate(page: params[:page], per_page: 20)
  end

  def help
  end

  def about
  end
end
