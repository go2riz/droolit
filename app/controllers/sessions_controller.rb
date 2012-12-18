class SessionsController < Devise::SessionsController

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "sessions#login_failure")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    respond_to do |format|
      format.html do
        @user = resource
        respond_with resource, :location => root_url
      end
      format.json do
        if user_signed_in?
          @user = resource
          @user.ensure_authentication_token!

          set_api_response("200", "Signed in successfully.")
          render :template => '/devise/sessions/signed_in'
        else
          set_api_response("400", "Invalid email/password.")
          render :template => '/devise/sessions/login_failure'
        end
      end
    end

  end
  
  def login_failure
    build_resource
    @user = resource

    set_api_response("400", "Invalid email/password.")
    render :template => '/devise/sessions/login_failure'
  end

end
