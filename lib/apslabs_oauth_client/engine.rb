require 'omniauth'
require 'apslabs_oauth_client/helper'

module ApslabsOauthClient
  class Engine < Rails::Engine

    initializer 'ApslabsOauthClient.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        extend ApslabsOauthClient::Helpers::ClassMethods
        include ApslabsOauthClient::Helpers::InstanceMethods
      end
    end

    initializer "omniauth" do |app|
      app.middleware.use OmniAuth::Builder do
        provider :apslabs, Rails.application.config.apslabs_federation_app_id, Rails.application.config.apslabs_federation_app_key, :site => Rails.application.config.apslabs_federation_url
      end
    end
  end
end

