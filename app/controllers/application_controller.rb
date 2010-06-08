# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :login_required

  def login_required
    if session[:atoken].blank?
      redirect_to verify_url
    end
  end

  def oauth
    @oauth ||= OAuth::Consumer.new(configatron.youroom.consumer.key, configatron.youroom.consumer.secret, :site => configatron.youroom.site_url)
  end

  def client
    return @client if @client
    @client = OAuth::AccessToken.new(oauth, session[:atoken], session[:asecret])
  end
end
