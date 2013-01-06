require 'spec_helper'

describe DroolController do

  login_user

  describe "POST 'create'" do

    it "should be successful" do
     template = FactoryGirl.create(:template)

      drool = {'title' => 'test', 'details' => 'test', 'status' => 'active'}
      drool_template_fields = [{"template_field_data" => "test data"}]

      post :create, format: :json, param: {:auth_token => @user.authentication_token, :template_id => template.id, :drool => drool, :drool_template_fields => drool_template_fields}
      response.should be_success
    end

  end

  describe "PUT 'update'" do

    it "should be successful" do
      drool = FactoryGirl.create(:drool)
      put :update, format: :json, param: {:id => drool.id, :auth_token => @user.authentication_token, :drool => {'title' => 'test', 'details' => 'test', 'status' => 'active'}}
      response.should be_success
    end

  end

  describe "DELETE 'destroy'" do

    it "should be successful" do
      drool = FactoryGirl.create(:drool)
      delete :destroy, format: :json, param: {:id => drool.id, :auth_token => @user.authentication_token}
      response.should be_success
    end

  end

end
