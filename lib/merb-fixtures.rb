if defined?(Merb::Plugins)
  # Configuration and initialization
  ORM = Merb.orm_generator_scope
  Merb::Plugins.config[:fixtures] = {
    :directory => Merb.root / "app" / "fixtures",
    :autoload  => true
  }
  
  require "merb-fixtures/shared/kernel.rb"
  require "merb-fixtures/shared/fixture.rb"
  require "merb-fixtures/shared/helpers.rb"
  require "merb-fixtures/shared/extensions.rb"
  require "merb-fixtures/shared/orm.rb"
  require "merb-fixtures/#{ORM}/#{ORM}"
  
  # Fixture loading
  Merb::BootLoader.after_app_loads do
    if Merb::Plugins.config[:fixtures][:autoload]
      Merb.logger.debug("Loading fixtures ...")
      unless Merb.env?("production")
        directory = Merb::Plugins.config[:fixtures][:directory]
        if File.exist?(directory)
          Dir[directory / "*.rb"].each do |file|
            require file
          end
        else
          raise "Fixtures directory not found."
        end
      end
    end
  end

  # Rakefiles
  Merb::Plugins.add_rakefiles("merb-fixtures/shared/merbtasks", "merb-fixtures/#{ORM}/merbtasks")
end