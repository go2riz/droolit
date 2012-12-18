object @api_response => :response
attributes :code, :status, :details

child @user do
attributes :authentication_token
  node :errors do |model|
    errors = []
    if !@user.confirmed?
      errors << "You must confirm your account before continuing."
    else
      errors << "Invalid email or password."
    end
  end
end
