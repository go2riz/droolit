class PasswordsController < Devise::ConfirmationsController

  prepend_before_filter :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  append_before_filter :assert_reset_token_passed, :only => :edit

  def new
    super
  end

  def create
    super
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
          render :template => '/devise/passwords/changed'
        else
          set_api_response("422", "Failed to reset password.")
          render :template => '/devise/passwords/new'
        end
      }

      format.any{super}
    end

  end

end
