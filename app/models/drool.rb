class Drool

  include Mongoid::Document
  include ::Mongoid::Timestamps
  include Mongoid::Search

  field :title
  field :details
  field :location
  field :ip_address
  field :latitude, :type => BigDecimal
  field :longitude, :type => BigDecimal
  field :status, :default => "active"
  field :display_order
  field :expires_on, default: ->{ 6.months.from_now }
  field :visibility, :default => "public"
  field :me2_group_code
  field :drool_type, :default => 'USER'
  field :source_link
  field :site_id, :type => Integer
  
  belongs_to :template
  belongs_to :owner, :class_name => 'User', :inverse_of => :drools

  has_one :address, as: :addressable

  has_many :drool_template_fields

  validates :title, :presence => true, :length => {:maximum => 255, :allow_blank => true}
  validates :details, :length => {:maximum => 1000, :allow_blank => true}
  validates :status, :presence => true, :inclusion => {
    :in => ["active", "expired", "reported", "deleted", "blocked", "withdrawn"], :allow_blank => true
  }

  search_in :title, :location, :latitude, :longitude,
    :created_at, :updated_at, :address => [:city, :state, :postcode, :country_code]

end
