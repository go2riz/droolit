class TemplateField
  
  field :label
  field :required
  field :display_message
  field :hint
  field :datatype
  field :max_length, :type => Integer
  field :default_value
  field :display_order, :type => Integer
  field :status
  
  belongs_to :template

  has_many :drool_template_fields

  validates :label, :presence => true, :length => {:maximum => 255, :allow_blank => true}
  validates :required, :presence => true, :inclusion => {:in => ["active", "inactive"], :allow_blank => true}
  validates :display_message, :presence => true, :length => {:maximum => 1000}
  validates :datatype, :presence => true, :inclusion => {:in => ["string", "integer", "decimal", "date", "time", "boolean"], :allow_blank => true}
  validates :max_length, :presence => true, :numericality => {:only_integer => true}, :if => Proc.new {|t| t.datatype == "string" }
  validates :status, :presence => true, :inclusion => {:in => ["active", "inactive"], :allow_blank => true}

end