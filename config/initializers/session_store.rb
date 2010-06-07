# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_crm_on_yrm_session',
  :secret      => 'b9f23be4b7889a210414602b0f013b621d58999a88d8a0dd7b10805984e472683a597d529d7b8109ce14ece848f30ca600eb0981d86fd8f188c0331bc3d73a8d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
