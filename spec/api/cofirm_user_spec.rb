require 'spec_helper'


describe "confirm user" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it "user confirmation successful" do
    @expected = {
        :response => {
            :status => "OK",
            :code => "200",
            :message => "User has been confirmed successfully.",
            :user => {
                :id => @user.id,
                :droolit_alias => @user.droolit_alias,
                :email => @user.email,
                :errors => []
            }
        }
    }.to_json
    get "/users/confirmation.json?confirmation_token=#{@user.confirmation_token}"
    response.should be_success
    response.body.should == @expected
  end

  it "user confirmation failed" do
    @expected = {
        :response => {
            :status => "Unprocessable Entity",
            :code => "422",
            :message => "Failed to confirm user.",
            :user => {
                :errors => ["Confirmation token is invalid"]
            }
        }
    }.to_json
    get "/users/confirmation.json?confirmation_token=testfail"
    response.should be_success
    response.body.should == @expected
  end

end