class Address

  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :city
  field :state
  field :postcode
  field :country_code

  belongs_to :addressable, polymorphic: true

end
