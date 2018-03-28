class LikesController < ApplicationController

  def create
   like          = Like.new
   activity      = Activity.find params[:activity_id]
   like.activity = activity
   like.user     = User.first # current_user
   if like.save
     redirect_to root_path, notice: "Thanks for liking!"
   else
     redirect_to root_path, alert: "Can't like! Liked already?"
   end
 end

 def destroy
    like = Like.find_by user_id: params[:id], activity_id: params[:activity_id]
    like.destroy
   redirect_to root_path, notice: "Like removed!"
 end


end
