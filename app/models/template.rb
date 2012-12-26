class Template

  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :description
  field :status
  
  has_many :template_fields

  validates :description, :presence => true
  validates :status, :presence => true, :inclusion => {:in => ["active", "inactive"], :allow_blank => true}

end
