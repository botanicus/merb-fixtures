if defined?(Merb::Plugins)
  # Configuration and initialization
  # For development - you can use dependency "/Users/..."
  $: << File.dirname(__FILE__)
  ORM = Merb.orm_generator_scope
  Merb::Plugins.config[:fixtures] = {
    :directory => Merb.root / "app" / "fixtures",
    :autoload  => true,
    :helpers   => true
  }
  
  require "merb-fixtures/shared/errors"
  require "merb-fixtures/shared/kernel"
  require "merb-fixtures/shared/fixture"
  require "merb-fixtures/shared/fixtures"
  require "merb-fixtures/shared/helpers"
  require "merb-fixtures/shared/extensions"
  require "merb-fixtures/shared/orm"
  require "merb-fixtures/#{ORM}/#{ORM}"
  
  # Fixture loading
  Merb::BootLoader.after_app_loads do
    if Merb::Plugins.config[:fixtures][:autoload]
      require "merb-fixtures/shared/fixtures"
      Merb::Fixtures.load!
    end
  end

  # Rakefiles
  Merb::Plugins.add_rakefiles("merb-fixtures/shared/merbtasks.rake", "merb-fixtures/#{ORM}/merbtasks.rake")
end