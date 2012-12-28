class DroolTemplateField
  
  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :template_field_data

  belongs_to :drool
  belongs_to :template_field

  validate :check_template_field_data
  validate :check_template_field_data_required

  def check_template_field_data
    return if template_field.datatype.blank? || template_field_data.blank?
    case template_field.datatype
      when "integer"
        errors.add(:template_field_data, "must be an integer.") if template_field_data.match(/\A[+-]?\d{0,12}\z/).nil?
      when "decimal"
        errors.add(:template_field_data, "must be a decimal number.") if template_field_data.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
      when "date"
        errors.add(:template_field_data, "must be in the format mm/dd/yyyy.") if (Date.parse(template_field_data) rescue nil).nil?
      when "time"
        errors.add(:template_field_data, "must be in the format mm/dd/yyyy hh:mm:ss.") if (Time.parse(template_field_data) rescue nil).nil?
      when "boolean"
        errors.add(:template_field_data, "must be a boolean value.") unless ["true", "false", "0", "1"].include?(template_field_data)
    end
  end

  def check_template_field_data_required
    return if template_field.datatype.blank?
    case template_field.required
      when "yes"
        errors.add(:template_field_data, "cannot be empty.") if template_field_data.blank?
    end
  end

end
