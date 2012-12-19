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
          set_api_response("200", "Password has been changed successfully.")
          render :template => '/devise/passwords/changed'
        else
          set_api_response("422", "Failed to change password.")
          render :template => '/devise/passwords/new'
        end
      }

      format.any{super}
    end

  end

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    super
  end

  def assert_reset_token_passed
    super
  end

  def unlockable?(resource)
    super
  end

end
