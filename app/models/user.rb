class User
  include Mongoid::Document
  include ::Mongoid::Timestamps
  include Mongoid::FullTextSearch

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :token_authenticatable, :confirmable, :async
       
  field :droolit_alias
  field :name

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  
  validates :droolit_alias, :presence => true, :uniqueness => true, :format => {:with => /^[A-Za-z\d_]+$/, :message => "can only be alphanumeric with no spaces"}
  
 # validates_presence_of :encrypted_password
  validate :check_app_id
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String
  
  field :activation_token, :type => String
  field :deleted_at, :type => Time
  
  attr_accessor :app_id
  
  has_and_belongs_to_many :apps
  has_many :integrated_services
  
  before_save :set_default_apps
  
  fulltext_search_in :droolit_alias, :email
  
  class << self
    
    def valid_activation_token?(token)
      where(activation_token: token).present?
    end
    
  end

  def app_id= name
    @app_id = name
    app = App.where(name: name).first
    self.apps << app if app
  end
  
  def app_id
    return @app_id if @app_id.present?
    self.apps.first.try(:name)
  end

  def soft_delete
    return false if deleted_at.present?
    update_attributes(:deleted_at => Time.current, :activation_token => Devise.friendly_token)
  end
  
  def disabled?
    deleted_at.present?
  end
  
  def activate!
    update_attributes(:deleted_at => nil, :activation_token => nil)
  end

  private
  
  def set_default_apps
    self.apps = App.defaults if apps.empty?
  end
  
  def check_app_id
    errors.add(:app, "id is invalid.") if app_id.present? && App.where(name: app_id).empty?
  end
  
end
