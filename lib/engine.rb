require 'omniauth'
require 'apslabs_helper'

module ApslabsOauthClient
  class Engine < Rails::Engine
    ActionController::Base.helper ApslabsOauthClient::Rails::Helper

    initializer "omniauth" do |app|
      app.middleware.use OmniAuth::Builder do
        provider :apslabs, Rails.application.config.apslabs_federation_app_id, Rails.application.config.apslabs_federation_app_key, :site => Rails.application.config.apslabs_federation_url
      end
    end
  end
end

