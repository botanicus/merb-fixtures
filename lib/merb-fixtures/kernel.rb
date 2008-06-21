module Kernel
  def fixture_for(klass, name, &block)
    # Post.new
    instance = klass.new
    instance.instance_eval(&block) if block_given?
    klass.fixture.create(name, instance)
    return instance
  end
end