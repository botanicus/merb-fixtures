# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash 
  # ...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:fixtures] = {
    :chickens => false
  }
  
  # Warning: do NOT put this requires into Merb::BootLoader!
  # Otherwise it load in bad time and everything collapse!
  require "merb-fixtures/kernel.rb"
  require "merb-fixtures/fixture.rb"
  require "merb-fixtures/helpers.rb"
  # TODO: use default ORM
  require "merb-fixtures/datamapper.rb"
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
  end

  Merb::BootLoader.after_app_loads do
    # require code that must be loaded before the application
    unless Merb.env?("production")
      if File.exist?(Merb.root / "app" / "fixtures")
        Dir["#{Merb.root}/app/fixtures/*.rb"].each do |file|
          require file
        end
      end
    end
  end
  
  Merb::Plugins.add_rakefiles "merb-fixtures/merbtasks"
end