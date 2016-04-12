class StaticPagesController < ApplicationController
  def home
  #   @image = current_user.images.build if logged_in?
  # 	#@feed_items = current_user.feed.paginate(page: params[:page], per_page: 20)
  # 	@feed_items = Image.paginate(page: params[:page], per_page: 20)
  if logged_in?
  @image  = current_user.images.build
  @feed_items = current_user.feed.paginate(page: params[:page])
  else
  @feed_items = Image.paginate(page: params[:page], :per_page => 20)
  end
  end

  def help
  end

  def about
  end
end
