object @api_response => :response
attributes :code, :status, :details

child resource do
  node :errors do |model|
    []
  end
end
