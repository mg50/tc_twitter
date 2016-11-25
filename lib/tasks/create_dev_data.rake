namespace :db do
  desc "create a bunch of users and tweets"
  task :create_dev_data => :environment do
    CreateDevData.execute
  end
end

class CreateDevData
  def self.execute
    names = File.read(__dir__ + '/first_names.txt').split("\n")
    words = File.read(__dir__ + '/words.txt').split("\n")

    puts "creating random users..."
    users = create_users(names, 100)

    puts "creating random tweets..."
    create_tweets(users, words)

    puts "done! try logging in with email: #{users.first.username}@gmail.com, password: 123456"
  end

  def self.create_tweets(users, words)
    1000.times do
      user = users.sample
      create_tweet(user, words)
    end
  end

  def self.create_users(names, num_users)
    names.shuffle[1..num_users].map do |name|
      email = "#{name.downcase}@gmail.com"
      user = User.new(username: name.downcase, display_name: name,
                      password: '123456', email: email)
      user.save!
      user
    end
  end

  def self.create_tweet(user, words)
    word_length = 2 + rand(8)
    tweet_body = (1..word_length).map do
      word = words.sample
      word = '#' + word if rand(20) == 0
      word
    end.join(' ')
    Tweet.create!(user: user, body: tweet_body)
  end

  def self.random_string(length=4)
    (1..length).map { ('a'..'z').to_a.sample }.join ''
  end
end
