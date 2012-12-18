class App

  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :name
  field :is_default, :type => Boolean, :default => false
  
  has_and_belongs_to_many :users

  validates :name, :presence => true, :uniqueness => true
  
  scope :defaults, where(is_default: true)
  
  class << self
  
    def create_or_update attributes
      app = where(name: attributes[:name]).first
      app = App.new if app.nil?
      app.attributes = attributes
      app.save
    end
  
  end

end