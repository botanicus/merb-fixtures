if defined?(Merb::Plugins)
  def require_fixture_files
    libraries = %w(exceptions kernel fixture fixtures helpers extensions orm)
    libraries.each { |library| require "merb-fixtures/shared/#{library}" }
    require "merb-fixtures/#{ORM}/#{ORM}"
  end

  # Configuration and initialization
  # For development - you can use dependency "/Users/..."
  # Why it isn't done automatically? "." really is in load paths,
  # but require is done from /usr/bin/merb and "." is /usr/bin
  # ... at least I think so :)
  $: << File.dirname(__FILE__)
  ORM = Merb.orm
  default = {
    :directory => Merb.root / "app" / "fixtures",
    :autoload  => true,
    :helpers   => true }
  # TODO: send a Merb patch for this
  Merb::Plugins.config[:fixtures] = default.merge(Merb::Plugins.config[:fixtures])
  
  # Fixture loading
  Merb::BootLoader.after_app_loads do
    require_fixture_files
    if Merb::Plugins.config[:fixtures][:autoload]
      Merb::Fixtures.load
    end
  end

  # Rakefiles
  Merb::Plugins.add_rakefiles("merb-fixtures/shared/merbtasks", "merb-fixtures/#{ORM}/merbtasks")
  # It couldn't works, it can work just after app load
  # if Pathname($0).basename.to_s.eql?("rake")
  #   require_fixture_files
  # end
end