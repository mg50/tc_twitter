# About

This is a very basic Twitter clone written using Rails and React. I used Devise to save time for user sign-in, but I avoided using any other fancy libraries.

# Setting up

Clone the repo and run `rake db:create db:migrate`. You can then run `rake db:create_dev_data` to populate the database with a bunch of test users with (nonsensical) tweets. This command will also supply you with an email and password with which to log in as one of these test users.

Once you've done this, run `rails s` and head to `localhost:3000`.

# What features are available?

You can view Tweets (with hashtag support), create Tweets (once you've logged in), delete your own tweets, look at the tweets of specific users and search for tweets. Much like actual Twitter, you can search for tweets from specific users using the `from:@username` command. For example, `hello from:@bob` will search for tweets from @bob containing the word "hello."

# Running tests

Navigate to the root directory and just enter `rspec`.

# Improvements

I ran into the requested timebox limit of 4 hours and subsequently wasn't able to provide good JS test coverage or focus on CSS (the style is almost completely bare-bones, currently). If you'd like me to go forward and fill these missing pieces in some more, I can do so.
