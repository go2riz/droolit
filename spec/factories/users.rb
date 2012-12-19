FactoryGirl.define do
  factory :user do
    droolit_alias "test"
    email "test@test.com"
    password "1234567"
    confirmation_token "test"
  end
end