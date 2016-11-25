require 'rails_helper'

describe SearchTweets do
  let!(:bob) { FactoryGirl.create :user, username: 'bob', email: 'bob@bob.com' }
  let!(:joe) { FactoryGirl.create :user, username: 'joe', email: 'joe@joe.com' }

  def create_tweet(user, body)
    FactoryGirl.create :tweet, user: user, body: body
  end

  it 'finds an empty array when there are no tweets' do
    expect(SearchTweets.execute('')).to be_empty
  end

  it 'finds a tweet' do
    t = create_tweet bob, 'hello world'
    expect(SearchTweets.execute('')).to eq([t.as_json])
  end

  it 'finds tweets matching a string' do
    t1 = create_tweet bob, 'hello world'
    t2 = create_tweet bob, 'goodbye world'
    expect(SearchTweets.execute('world')).to eq([t2, t1].map &:as_json)
  end

  it 'finds tweets in descending order of creation date' do
    t1 = create_tweet bob, 'goodbye world'
    t2 = create_tweet bob, 'hello world'
    expect(SearchTweets.execute('world')).to eq([t2, t1].map &:as_json)
  end

  it 'finds all tweets when no search string is specified' do
    t1 = create_tweet bob, 'hello world'
    t2 = create_tweet bob, 'foo'
    t3 = create_tweet joe, 'goodbye world'
    expect(SearchTweets.execute('')).to eq([t3, t2, t1].map &:as_json)
  end

  it 'finds a subset of tweets when only some match the search string' do
    t1 = create_tweet bob, 'hello world'
    t2 = create_tweet bob, 'foo'
    t3 = create_tweet joe, 'goodbye world'
    expect(SearchTweets.execute('world')).to eq([t3, t1].map &:as_json)
  end

  it 'understands how to search by user' do
    t1 = create_tweet bob, 'hello world'
    t2 = create_tweet bob, 'foo'
    t3 = create_tweet joe, 'goodbye world'
    expect(SearchTweets.execute('world from:@bob')).to eq([t1].map &:as_json)
  end

  it "doesn't care where the user filter occurs in the search string" do
    t1 = create_tweet bob, 'hello world'
    t2 = create_tweet bob, 'foo'
    t3 = create_tweet joe, 'goodbye world'
    expect(SearchTweets.execute('from:@bob world')).to eq([t1].map &:as_json)
  end

  it 'handles the case where only user is specified' do
    t1 = create_tweet bob, 'hello world'
    t2 = create_tweet bob, 'foo'
    t3 = create_tweet joe, 'goodbye world'
    expect(SearchTweets.execute('from:@bob')).to eq([t2, t1].map &:as_json)
  end
end
