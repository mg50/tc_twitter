class UsersController < ApplicationController
  def show
    user = User.find_by username: params[:username]
    if user
      tweets = user.tweets.order(created_at: :desc).map(&:as_json)
    else
      tweets = []
    end

    render_app displayIncoming: user == current_user, tweets: tweets
  end
end
