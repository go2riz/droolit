object @api_response => :response
attributes :code, :status, :details

child current_user do
attributes :is_admin
end
