object @api_response => :response
attributes :code, :status, :details

child @object do
  node :errors do |model|
    ["No template exists with this id."]
  end
end
