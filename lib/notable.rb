require 'rubygems'
require 'xmpp4r'
require 'dm-core'
require 'dm-timestamps'

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}"

require 'notable/note'
require 'notable/note_taker'
require 'notable/configuration'

module Notable
  class BadConfiguration < StandardError; end;

  ##
  # Creates a new configuration from the given filename and saves it in a class
  # variable.
  #
  # At a minimum the configuration should offer jabber username and
  # password, and details of the database
  #
  # The configuration is used to set up a NoteTaker
  def self.setup(filename)
    @@configuration = Configuration.new(filename)
    @@note_taker = NoteTaker.new(configuration.jabber_username,
                                 configuration.jabber_password,
                                 configuration.jabber_options)
  end

  def self.connect
    DataMapper.setup(:default, configuration.database)
    @@note_taker.connect
  end

  ##
  # Provides access to the Configuration
  def self.configuration
    @@configuration
  end

  ##
  # Provides access to the NoteTaker
  def self.note_taker
    @@note_taker
  end
end

