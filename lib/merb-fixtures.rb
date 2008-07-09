if defined?(Merb::Plugins)
  # Configuration and initialization
  # For development - you can use dependency "/Users/..."
  # Why it isn't done automatically? "." really is in load paths,
  # but require is done from /usr/bin/merb and "." is /usr/bin
  # ... at least I think so :)
  $: << File.dirname(__FILE__)
  ORM = Merb.orm_generator_scope
  default = {
    :directory => Merb.root / "app" / "fixtures",
    :autoload  => true,
    :helpers   => true }
  # TODO: send a Merb patch for this
  Merb::Plugins.config[:fixtures] = default.merge(Merb::Plugins.config[:fixtures])
  
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
      Merb::Fixtures.load
    end
  end

  # Rakefiles
  Merb::Plugins.add_rakefiles("merb-fixtures/shared/merbtasks.rake", "merb-fixtures/#{ORM}/merbtasks.rake")
end