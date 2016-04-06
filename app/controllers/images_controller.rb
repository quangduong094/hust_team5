class ImagesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :edit]
	before_action :correct_user, only: [:destroy]
    def show
    end

    def create
    	@image = current_user.images.build(image_params)
		if @image.save
			flash[:success] = "Image created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
    end

    def destroy
    	@image.destroy
		flash[:success] = "Image deleted"
		redirect_to request.referrer || root_url
    end



    private
    def image_params
    	params.require(:image).permit(:title, :file)
    end

    def correct_user
		@image = current_user.images.find_by(id: params[:id])
		redirect_to root_url if @image.nil?
	end
end
