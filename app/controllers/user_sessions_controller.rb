class UserSessionsController < ApplicationController
  before_filter :login_required, :only => [ :destroy ]
  skip_before_filter :login_required, :except => [ :destroy ]

  # omniauth callback method
  def create
    auth = request.env["omniauth.auth"]

    user = User.find_by_omniauth(auth) || User.create_with_omniauth(auth)
    user.update_with_omniauth(auth) && (session[:user_id] = user.id)

    redirect_to(root_url, :notice => 'Successfully logged in')
  end

  # Omniauth failure callback
  def failure
    redirect_to(Rails.application.config.apslabs_federation_url, :error => params[:message])
  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    session[:user_id] = nil

    redirect_to(URI(Rails.application.config.apslabs_federation_url).merge('/logout').to_s, :notice => 'You have successfully signed out!')
  end
end

