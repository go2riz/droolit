class IntegratedService
  include Mongoid::Document
  include ::Mongoid::Timestamps

  field :service_provider
  field :provider_user_id
  field :auth_token

  embedded_in :user

  def set_integrated_service user, param_hash
    user.integrated_services.create(param_hash)
  end

end
