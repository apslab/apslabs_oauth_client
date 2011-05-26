module ApslabsOauthClient
  module Helpers

    module ClassMethods
      helper_method :current_user
      helper_method :user_signed_in?
      helper_method :login_required
      helper_method :current_company
    end

    module InstanceMethods
      def current_user
        return nil unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end

      def user_signed_in?
        !!current_user
      end

      def login_required
        unless user_signed_in?
          respond_to do |format|
            format.html {redirect_to '/auth/apslabs'}
            format.json {render :json => { 'error' => 'Access Denied' }.to_json}
          end
        end
      end

      def current_company
        @current_company ||= current_user.current_company || current_user.companies.first
      end

    end

  end
end

