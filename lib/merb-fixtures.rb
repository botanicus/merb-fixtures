# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash 
  # ...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:fixtures] = {
    :directory => Merb.root / "app" / "fixtures"
  }
  
  # Warning: do NOT put this requires into Merb::BootLoader!
  # Otherwise it load in bad time and everything collapse!
  ORM = Merb.orm_generator_scope
  require "merb-fixtures/shared/kernel.rb"
  require "merb-fixtures/shared/fixture.rb"
  require "merb-fixtures/shared/helpers.rb"
  require "merb-fixtures/shared/extensions.rb"
  require "merb-fixtures/#{ORM}/#{ORM}"
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
  end

  Merb::BootLoader.after_app_loads do
    # require code that must be loaded before the application
    unless Merb.env?("production")
      if File.exist?(Merb.root / "app" / "fixtures")
        Dir[Merb::Plugins.config[:fixtures][:directory] / "*.rb"].each do |file|
          require file
        end
      end
    end
  end
  
  Merb::Plugins.add_rakefiles "merb-fixtures/#{ORM}/merbtasks"
end