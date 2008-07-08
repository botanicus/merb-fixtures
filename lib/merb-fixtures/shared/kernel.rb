module Kernel
  def fixture_for(klass, name, &block)
    include Merb::Fixtures::Helpers if Merb::Plugins.config[:fixtures]
    instance = klass.new # Post.new
    instance.instance_eval(&block) if block_given?
    klass.fixture.create(name, instance)
    return instance
  end
end