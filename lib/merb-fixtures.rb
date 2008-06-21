# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:fixtures] = {
    :chickens => false
  }
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
    require Merb.root / "lib/fixtures/lib/merb-fixtures/fixtures.rb"
    require Merb.root / "lib/fixtures/lib/merb-fixtures/kernel.rb"
    require Merb.root / "lib/fixtures/lib/merb-fixtures/helpers.rb"
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "fixtures/merbtasks"
end