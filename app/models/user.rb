class User < ActiveRecord::Base
  has_many :tweets
  #has_many :tweets, through: :likes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
