class DroolTemplateField
  
  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :template_field_data

  belongs_to :drool
  belongs_to :template_field

  validate :check_template_field
  validate :check_template_field_data_type
  validate :check_template_field_data_required


  def check_template_field_data_type
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

  def check_template_field
    errors.add(:template_field, "cannot find template field.") if !template_field
  end

  def self.save_drool_template_fields drool, drool_template_fields
    drool_template_fields.each do |drool_template_field|
      drool_template_field_obj = drool.drool_template_fields.build(drool_template_field)
      drool_template_field_obj.save
    end
  end

  def self.update_drool_template_fields drool, drool_template_fields
    drool_template_fields.each do |drool_template_field|
      drool_template_field_obj = DroolTemplateField.find(drool_template_field[:id])
      drool_template_field_obj.update_attributes(drool_template_field) if drool_template_field_obj
    end
  end

end
