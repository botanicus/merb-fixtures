# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:fixtures] = {
    :chickens => false
  }
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
    require "merb-fixtures/fixture.rb"
    # TODO: use default ORM
    require "merb-fixtures/datamapper.rb"
    require "merb-fixtures/kernel.rb"
    require "merb-fixtures/helpers.rb"
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "merb-fixtures/merbtasks"
end