class ImagesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :edit]
	before_action :correct_user, only: [:destroy, :edit]
    def show
    end

    def create
    	@image = current_user.images.build(image_params)
		if @image.save
			flash[:success] = "Image created!"
			redirect_to root_url
		else
			@feed_items = []
			redirect_to request.referrer || @current_user
		end
    end

    def destroy
    	@image.destroy
		flash[:success] = "Image deleted"
		redirect_to @current_user
    end
    
    def show
    	@image = Image.find(params[:id])
    	@comment = @image.comments.build
  		@comments = @image.comments.paginate(page: params[:page])
    end

	def edit
    	@image = Image.find(params[:id])
  	end

  	def update
    	@image = Image.find(params[:id])
	    if @image.update_attributes(image_params)
	      flash[:success] = "Update image"
	      redirect_to @image
	    else
	      render 'edit'
	    end
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
