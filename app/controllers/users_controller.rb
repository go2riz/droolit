class UsersController < ApplicationController
  
  prepend_before_filter :check_auth_token
  before_filter :authenticate_user!
  
  respond_to :json
  
  def index
    @users = User.fulltext_search("#{params[:droolit_alias]} #{params[:email]}")
    set_api_response("200", @users.present? ? "#{@users.size} users found." : "No user found.")

    respond_to do |format|
      format.json{
        render "index"
      }
    end

  end

  def edit
    @user = current_user
  end

  def change_password
    @user = User.find(current_user.id)

    respond_to do |format|
      format.json{
        if @user.update_attributes(params[:user])
          set_api_response("200", "Password has been updated successfully.")
        else
          set_api_response("422", "Failed to change password.")
        end
        
      }
    end

  end
  
  def is_admin
    respond_to do |format|
      format.json{
        set_api_response("200", "User #{@user.is_admin ? "have": "does not have"} admin privileges.")
      }
    end
  end

end
