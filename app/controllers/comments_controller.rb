class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
	def create
		@image = Image.find(params[:image_id])
		@comment = @image.comments.build(comment_params)
		@comment.user_id = current_user.id
		if current_user.following?(@image.user) || current_user == @image.user
			if @comment.save
				respond_to do |format|
        			format.html do
          				redirect_to image_path(@image)
        			end
        		format.js # JavaScript response
      			end
			else
			 	flash[:warning]= "You can not comment on this post"
			    redirect_to image_path(@image)
			end
		else
			redirect_to image_path(@image)
		end
	end
	
    def destroy
        @image = Image.find params[:image_id]
        @comment = @image.comments.find(params[:id])
        @delete_id = @comment.id
        @comment.destroy
        respond_to do |format|
          format.html do
        	flash[:success] = 'Comment deleted.'
        	redirect_to image_path(@image)
          end
          format.js # JavaScript response
        end
    end

	private

    def comment_params
        params.require(:comment).permit( :content)
    end
end
