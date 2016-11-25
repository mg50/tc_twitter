FactoryGirl.define do
  factory :user do
    username 'bob'
    display_name 'Bob'
    email 'bob@bob.com'
    password 123456
  end
end
