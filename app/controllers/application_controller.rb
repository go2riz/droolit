class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def set_api_response code, details=""
    @api_response = ApiMessage.where(code: code).first
    @api_response.details = details if @api_response.present?
  end
  
end
