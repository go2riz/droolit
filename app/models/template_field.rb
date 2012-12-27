class TemplateField

  include Mongoid::Document
  include ::Mongoid::Timestamps

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
  belongs_to :owner, :class_name => 'User', :inverse_of => :template_fields

  has_many :drool_template_fields

  validates :label, :presence => true, :length => {:maximum => 255, :allow_blank => true}, :uniqueness => {:scope => :template_id, :allow_blank => true}
  validates :required, :presence => true, :inclusion => {:in => ["yes", "no"], :allow_blank => true}
  validates :display_message, :presence => true, :length => {:maximum => 1000}
  validates :datatype, :presence => true, :inclusion => {:in => ["string", "integer", "decimal", "date", "time", "boolean"], :allow_blank => true}
  validates :max_length, :presence => true, :numericality => {:only_integer => true, :allow_blank => true}, :if => Proc.new {|t| t.datatype == "string" }
  validates :status, :presence => true, :inclusion => {:in => ["active", "inactive"], :allow_blank => true}
  validates :display_order, :uniqueness => {:scope => :template_id}, :numericality => {:only_integer => true}, :allow_blank => true

  validate :check_display_order
  validate :check_default_value

  private
  
  def check_display_order
    if display_order.blank?
      self.display_order = TemplateField.max(:display_order) + 10
    elsif !display_order_mutiple_of_10?
      errors.add(:display_order, "must be a multiple of 10.")
    end
  end
  
  def check_default_value
    return if datatype.blank? || default_value.blank?
    case datatype
    when "integer"
      errors.add(:default_value, "must be an integer.") if default_value.match(/\A[+-]?\d{0,12}\z/).nil?
    when "decimal"
      errors.add(:default_value, "must be a decimal number.") if default_value.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
    when "date"
      errors.add(:default_value, "must be in the format mm/dd/yyyy.") if (Date.parse(default_value) rescue nil).nil?
    when "time"
      errors.add(:default_value, "must be in the format mm/dd/yyyy hh:mm:ss.") if (Time.parse(default_value) rescue nil).nil?
    when "boolean"
      errors.add(:default_value, "must be a boolean value.") unless ["true", "false", "0", "1"].include?(default_value)
    end
  end
  
  def display_order_mutiple_of_10?
    display_order.to_i % 10 == 0
  end

end