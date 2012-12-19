class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :check_auth_token
  
  protected
  
  def set_api_response code, details=""
    @api_response = ApiMessage.where(code: code).first
    @api_response.details = details if @api_response.present?
  end
  
  def check_auth_token
    @user = User.where(authentication_token: params[:auth_token]).first
    
    if @user.nil? || !@user.confirmed?
      set_api_response("401", "Unauthorized access.")
      render :template => "/devise/shared/authentication_failed"
    end
  end
  
  
end
