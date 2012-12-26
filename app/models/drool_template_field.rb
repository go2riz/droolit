class DroolTemplateField
  
  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :answer

  belongs_to :drool
  belongs_to :template_field

end
