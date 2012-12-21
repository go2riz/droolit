object @api_response => :response
attributes :code, :status, :details

child @user do
  node :errors do |model|
    errors = []
    if !@user.confirmed?
      errors << "You must confirm your account before continuing."
    elsif @user.disabled?
      errors << "You account has been disabled."
    else
      errors << "Invalid email or password."
    end
  end
end
