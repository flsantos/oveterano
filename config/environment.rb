# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present

#Essa linha é pra rodar local
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
#Essa linha é pra rodar no servidor
#RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration


#if Gem::VERSION >= "1.3.6" 
#    module Rails
#        class GemDependency
#            def requirement
#                r = super
#                (r == Gem::Requirement.default) ? nil : r
#            end
#        end
#    end
#end







require File.join(File.dirname(__FILE__), 'boot')
  

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Brasilia'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  config.gem 'will_paginate', :version => '~> 2.3.15', :source => 'http://gemcutter.org'
#  config.gem "friendly_id", :version => "~> 3.2.1"

  

end

require "will_paginate"
#require "friendly_id"
#require "friendly_id/active_record2"
#require "nokogiri"

Date::MONTHNAMES = [nil] + %w(Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro)  
#Date::DAYNAMES = %w(Domingo Segunda-Feira Terça-Feira Quart-Feira Quinta-Feira Sexta-Feira Sábado)  
Date::ABBR_MONTHNAMES = [nil] + %w(Jan Fev Mar Abr Mai Jun Jul Aug Sep Out Nov Dez)  
#Date::ABBR_DAYNAMES = %w(Dom Seg Ter Qua Qui Sex Sab)
class Time  
  alias :strftime_nolocale :strftime  
  def strftime(format)  
    format = format.dup  
    format.gsub!(/%a/, Date::ABBR_DAYNAMES[self.wday])  
    format.gsub!(/%A/, Date::DAYNAMES[self.wday])  
    format.gsub!(/%b/, Date::ABBR_MONTHNAMES[self.mon])  
    format.gsub!(/%B/, Date::MONTHNAMES[self.mon])  
    self.strftime_nolocale(format)  
  end  
end




