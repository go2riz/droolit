class ApiMessage

  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :status
  field :code
  
  attr_accessor :details

  validates :status, :presence => true
  validates :code, :presence => true, :uniqueness => true
  
  class << self
  
    def create_or_update attributes
      api_message = where(code: attributes[:code]).first
      api_message = ApiMessage.new if api_message.nil?
      api_message.attributes = attributes
      api_message.save
    end
  
  end

end