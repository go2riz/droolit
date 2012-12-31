object @drool
attributes :id, :title, :details, :location, :ip_address, :latitude, :longitude,
  :status, :display_order, :visibility, :me2_group_code, :drool_type, :source_link, :site_id
node(:expires_on) {|drool| drool.expires_on.to_s:default }

child :address do
  extends "addresses/show"
end

