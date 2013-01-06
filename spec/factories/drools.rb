FactoryGirl.define do
  factory :drool do
    title "test"
    details "test details"
    location "test location"
    ip_address "127.0.0.1"
    latitude "50.00145"
    longitude "41.007"
    status "active"
    display_order null
    visibility "public"
    me2_group_code "45k41"
    drool_type "USER"
    source_link null
    site_id null
    address_id null
  end
end