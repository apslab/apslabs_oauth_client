# Change this omniauth configuration to point to your registered provider
module OmniAuth
  module Strategies
    autoload :Apslabs, 'apslabs_oauth_strategy'
  end
end

