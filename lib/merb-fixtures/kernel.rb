module Kernel
  def fixture_for(klass, name, &block)
    # Post.new
    instance = klass.new
    instance.instance_eval(&block)
    klass.fixture.create(name, instance)
    return instance
  end
end