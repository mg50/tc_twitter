class Tweet < ActiveRecord::Base
  MAX_TWEET_LENGTH = 140

  belongs_to :user
  validates :body, length: {minimum: 1, maximum: MAX_TWEET_LENGTH}
  # scope :visible_to_user, ->(user) {
  #   Tweet.joins(:users)
  #        .where('public = true OR something')
  # }

  def as_json
    {id: id,
     userId: user.id,
     username: user.username,
     displayName: user.display_name,
     body: body}
  end
end
