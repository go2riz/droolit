object @api_response => :response
attributes :code, :status, :details

child @object do
  node :errors do |model|
    ["You are not authorized for this #{@object.class.name.underscore.gsub("_", " ")}."]
  end
end
