object @api_response => :response
attributes :code, :status, :details

child @object do
  node :errors do |model|
    ["No #{@object.class.name.underscore.gsub("_", " ")} exists with this id."]
  end
end
