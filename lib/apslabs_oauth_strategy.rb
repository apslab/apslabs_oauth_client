require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
 module Strategies

   class Apslabs < OAuth2

     def initialize(app, client_id = nil, client_secret = nil, options = {}, &block)
       client_options = {
         :site => 'http://federation.apslabs.com.ar/',
         :authorize_path => '/auth/oauth/authorize',
         :access_token_path => '/auth/oauth/access_token'
       }.update(options)

       super(app, :apslabs, client_id, client_secret, client_options, &block)
     end

     protected

     def user_data
       @data ||= MultiJson.decode(@access_token.get("/auth/oauth/user"))
     end

     def user_hash
       raise "user_hash was call"
     end

     def request_phase
       self.options[:scope] ||= "read"
       super
     end

     def auth_hash
       OmniAuth::Utils.deep_merge(super, {
          'uid' => user_data["uid"],
          'user_info' => user_data['user_info'],
          'extra' => {
              'first_name' => user_data['extra']['first_name'],
              'last_name' => user_data['extra']['last_name'],
              'memberships' => user_data['extra']['memberships']
          }
       })
     end

   end
 end
end

