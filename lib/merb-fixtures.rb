if defined?(Merb::Plugins)
  # Configuration and initialization
  ORM = Merb.orm_generator_scope
  Merb::Plugins.config[:fixtures] = {
    :directory => Merb.root / "app" / "fixtures",
    :autoload  => true
  }
  
  require "merb-fixtures/shared/kernel.rb"
  require "merb-fixtures/shared/fixture.rb"
  require "merb-fixtures/shared/fixtures.rb"
  require "merb-fixtures/shared/helpers.rb"
  require "merb-fixtures/shared/extensions.rb"
  require "merb-fixtures/shared/orm.rb"
  require "merb-fixtures/shared/errors.rb"
  require "merb-fixtures/#{ORM}/#{ORM}"
  
  # Fixture loading
  Merb::BootLoader.after_app_loads do
    if Merb::Plugins.config[:fixtures][:autoload]
      Merb::Fixtures.load
    end
  end

  # Rakefiles
  Merb::Plugins.add_rakefiles("merb-fixtures/shared/merbtasks.rake", "merb-fixtures/#{ORM}/merbtasks.rake")
end