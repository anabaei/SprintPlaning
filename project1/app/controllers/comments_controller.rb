class CommentsController < ApplicationController
  def index
  end

  def new
  end

  def create
  	  postid = params.require(:post_id)
  	# #check later without permit 
  	  newcomment = Comment.new(params.require(:comment).permit(:body)) 
  	
  	 newcomment.post_id = postid

  	 # @post = Post.find params[:post_id]
    # newcomment = @post.comments.build(params.require(:comment).permit(:body))
   # @answer.user = current_user

  	if(newcomment.save)
     redirect_to posts_path
    end  		
  
  end

  def show
  end
end
