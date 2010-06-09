ActionController::Routing::Routes.draw do |map|
  map.root :controller => "customers"

  map.resources :customers

  map.with_options :controller => "oauth" do |oauth|
    oauth.verify "/oauth/request_token", :action => "verify"
    oauth.callback "/oauth/access_token", :action => "callback"
    oauth.logout "/logout", :action => "logout"
  end
end
