require 'spec/spec_helper'

describe "confirm user" do
  it "displays the user's name after successful confirmation" do
    user = User.create!(:droolit_alias => 'test', :email => 'test@gmail.com', :password => 'test', :app_id => 'droolit')
    get "/users/confirmation?confirmation_token=#{user.confirmation_token}"


  end
end