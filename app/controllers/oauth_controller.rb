class OauthController < ApplicationController
  skip_before_filter :login_required

  def verify
    reset_session

    request_token = session[:request_token] = oauth.get_request_token(:oauth_callback => callback_url)

    redirect_to request_token.authorize_url
  end

  def callback
    request_token = session[:request_token]
    access_token = request_token.get_access_token({}, :oauth_token => params[:oauth_token], :oauth_verifier => params[:oauth_verifier])
    logger.info "[Login] Successfull #{access_token.token}"

    reset_session
    session[:atoken], session[:asecret] = access_token.token, access_token.secret

    redirect_to root_url
  end

  def logout
    reset_session

    redirect_to root_url
  end
end
