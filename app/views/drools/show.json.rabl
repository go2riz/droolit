object @api_response => :response
attributes :code, :status, :details

child @drool do
attributes :id, :title, :details, :location, :ip_address, :latitude, :longitude, :status, :display_order, :visibility,
:me2_group_code, :drool_type, :source_link, :site_id, :template_id, :owner_id, :address_id

end
