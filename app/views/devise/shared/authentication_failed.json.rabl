object @api_response => :response
attributes :code, :status, :details

child User.new do
  node :errors do |model|
    ["Invalid authentication token."]
  end
end
