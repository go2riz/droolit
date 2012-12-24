require 'spec_helper'

describe UsersController do

  login_user

  describe "GET 'is_admin'" do

    it "should be successful" do
      get :is_admin, format: :json, param: {:auth_token => @user.authentication_token}
      response.should be_success
    end
    
  end
  
end