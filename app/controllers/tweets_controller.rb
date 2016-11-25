class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]

  def index
    tweets = SearchTweets.execute('')
    render_app displayIncoming: true, tweets: tweets
  end

  def create
    tweet = Tweet.new user: current_user, body: params[:body]
    if tweet.save
      render json: tweet.as_json
    else
      render json: {success: false}, status: 500
    end
  end

  def delete
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      tweet.destroy
      render json: {success: true}
    else
      render json: {success: false}, status: 403
    end
  end

  def search
    query = URI.decode(params[:query])
    tweets = SearchTweets.execute(query)
    render_app displayIncoming: false, tweets: tweets
  end
end
