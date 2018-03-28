class ActivitiesController < ApplicationController
  def index

    @activities = Activity.order(:name)
     # find_by current_user
    session[:user_id] = User.find_by(first_name: "John");
    @liked = Like.find_by(user_id: session[:user_id])
  end
end
