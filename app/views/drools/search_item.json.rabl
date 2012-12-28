object @drool
attributes :id, :title, :details, :location, :ip_address, :latitude, :longitude,
  :status, :display_order, :expires_on, :visibility, :me2_group_code, :drool_type, :source_link, :site_id

child :address do
  extends "addresses/show"
end

