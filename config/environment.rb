require 'bundler/setup'
Bundler.require

ENV["PLAYLISTER_ENV"] ||= "development"

Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}
require_relative "../app/models/concerns/slugifiable.rb"
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

DBRegistry[ENV["PLAYLISTER_ENV"]].connect!
DB = ActiveRecord::Base.connection

if ENV["PLAYLISTER_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end