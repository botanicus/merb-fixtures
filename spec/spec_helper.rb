$TESTING = true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

ORM = nil
module SpecHelper
  # model "User", :activerecord
  def model(orm = ORM, name = nil)
    case orm
    when :datamapper
      require "merb_datamapper"
      require "dm-core"
      eval %{ class ::#{name} ; include ::DataMapper::Resource ; end }
    when :activerecord
      require "active_record"
      require "merb_activerecord"
      eval %{ class ::#{name} < ActiveRecord::Base ; end }
    when :sequel
      require "sequel"
      require "merb_sequel"
      eval %{ class ::#{name} < Sequel::Model ; end }
    end
  end
  
  def models(orm, *names)
    names.each do |name|
      model orm, name
    end
  end
end

Spec::Runner.configure do |config|
  config.mock_with :rspec
end