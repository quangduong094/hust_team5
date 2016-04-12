class LikesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
	def create
		@image = Image.find(params[:image_id])
		@like = @image.likes.build(like_params)
		@like.user_id = current_user.id
		@like.save
		respond_to do |format|
            format.html { redirect_to @image }
            format.js
        end
	end

	def destroy
		like = Like.find(params[:id])
		@image = Image.find_by(id: like.image_id)
		like.destroy
	    respond_to do |format|
            format.html { redirect_to @image }
            format.js
        end
	end

	private
	def like_params
		params.require(:like).permit(:image_id, :user_id)
	end
end
