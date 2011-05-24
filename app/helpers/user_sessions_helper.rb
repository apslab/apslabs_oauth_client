module ApslabsOauthClient
  module UserSessionsHelper
    def current_user
      return nil unless session[:user_id]
      @current_user ||= User.find_by_uid(session[:user_id]['uid'])
    end

    def user_signed_in?
      !!current_user
    end
  end
end

