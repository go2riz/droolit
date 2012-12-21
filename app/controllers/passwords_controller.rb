class PasswordsController < Devise::ConfirmationsController

  prepend_before_filter :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  append_before_filter :assert_reset_token_passed, :only => :edit

  def new
    super
  end

  def create
    respond_with do |format|
      format.json {
        self.resource = resource_class.send_reset_password_instructions(resource_params)

        if successfully_sent?(resource)
          set_api_response("200", "Instructions to reset password has been sent to your email address.")
        else
          set_api_response("422", "Failed to send reset password instructions.")
        end
        render :template => '/devise/passwords/status'
      }

      format.any{super}
    end
  end

  def edit
    super
  end

  def update
    respond_with do |format|
      format.json {
        self.resource = resource_class.reset_password_by_token(resource_params)

        if resource.errors.empty?
          set_api_response("200", "Password has been reset successfully.")
        else
          set_api_response("422", "Failed to reset password.")
        end
        render :template => '/devise/passwords/status'
      }

      format.any{super}
    end

  end

end
