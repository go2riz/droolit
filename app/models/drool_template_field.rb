class DroolTemplateField
  
  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :template_field_data

  belongs_to :drool
  belongs_to :template_field

end
