# Change this omniauth configuration to point to your registered provider

module OmniAuth
  module Strategies
    autoload :Apslabs, 'apslabs_oauth_strategy'
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :apslabs, Rails.application.config.apslabs_federation_app_id, Rails.application.config.apslabs_federation_app_key, :site => Rails.application.config.apslabs_federation_url
end

