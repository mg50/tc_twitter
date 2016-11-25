require 'rails_helper'

describe TweetsController do
  let(:user) { FactoryGirl.create :user }

  before do
    sign_in user
  end

  describe 'delete' do
    it 'deletes a tweet belonging to the user' do
      tweet = FactoryGirl.create :tweet, user: user, body: 'test'
      post :delete, id: tweet.id
      expect(Tweet.count).to eq(0)
    end

    it 'does not delete a tweet belonging to another user' do
      user2 = FactoryGirl.create :user, username: 'joe', email: 'joe@gmail.com'
      tweet = FactoryGirl.create :tweet, user: user2, body: 'test'
      post :delete, id: tweet.id
      expect(Tweet.count).to eq(1)
      expect(response.status).to eq(403)
    end
  end

  describe '#create' do
    it 'creates a tweet' do
      post :create, body: 'test tweet'
      tweet = Tweet.last
      expect(tweet).to be_truthy
      expect(tweet.user).to eq(user)
      expect(tweet.body).to eq('test tweet')
    end
  end
end
