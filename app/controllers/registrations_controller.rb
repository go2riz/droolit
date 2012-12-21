class RegistrationsController < Devise::RegistrationsController
  
  skip_before_filter :check_auth_token, :only => [:new, :create, :activate]

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
        params[:user].delete(:email)
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

  def destroy
    respond_to do |format|
      format.json do
        if resource.soft_delete
          Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
          Devise.mailer.send(:cancelled_confirmation, resource).deliver
          set_api_response("200", "Your account has been cancelled successfully.")
          render :template => '/devise/registrations/cancelled'
        else
          set_api_response("422", "Failed to cancel your account.")
          render :template => '/devise/registrations/cancellation_failed'
        end
      end
    end
  end
  
  def activate
    build_activation_resource

    respond_to do |format|
      format.json do
        if resource.new_record? || !resource.disabled?
          set_api_response("422", "Failed to activate user.")
          render :template => '/devise/registrations/activation_failed'
        else
          resource.activate!
          Devise.mailer.send(:activation_confirmation, resource).deliver
          set_api_response("200", "User has been activated successfully. You can now sign in to your account.")
          render :template => '/devise/registrations/activated'
        end
      end
    end
  end

  def create_with_oauth
    respond_with do |format|
      format.json {
        build_resource

        if resource.save
          IntegratedService.set_integrated_service(resource, params[:integrated_service])
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

  protected
  
  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!")
    self.resource = send(:"current_#{resource_name}")
  end
  
  # Build a devise resource using activation token
  def build_activation_resource(hash=nil)
    hash ||= resource_params || {}
    self.resource = resource_class.where(activation_token: params[:token]).first
    self.resource = resource_class.new if self.resource.nil?
  end

end
