class RegistrationsController < Devise::RegistrationsController
  
  skip_before_filter :check_auth_token, :only => [:new, :create]

  def new
    super
  end
  
  def create
    respond_with do |format|
      format.json {
        build_resource

        if resource.save
          set_api_response("200", "User has been registered successfully.")
          render :template => '/devise/registrations/signed_up'
        else
          set_api_response("422", "Failed to register user.")
          render :template => '/devise/registrations/new'
        end
      }

      format.any{super}
    end
  end
  
  def update
    respond_to do |format|
      format.json do
        @user = current_user

        if @user.update_without_password(params[:user])
          set_api_response("200", "Profile has been updated successfully.")
        else
          set_api_response("422", "Failed to update user profile.")
        end

        render :template => '/devise/registrations/update'
      end
      
      format.any{super}
    end
  end

  protected
  
  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!")
    self.resource = send(:"current_#{resource_name}")
  end

end
