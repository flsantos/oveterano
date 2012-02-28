# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ofertaweb_unb_session',
  :secret      => 'ff5156d64c39a140827abfcd255e1069b064b02334344750ac9a38b1db1bb67b15747c773437a3c44995e86e56b44ffbbb499f3c70e30481eed461f1cab6ba75'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
