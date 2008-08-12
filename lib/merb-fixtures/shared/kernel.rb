module Kernel
  # Create new fixture for given model.
  #
  # ==== Parameters
  # klass<Class>::
  #   Model class
  # name<Symbol>::
  #   Name of the fixture object.
  #   Examples: :first_post, :default_author
  #
  # ==== Returns
  # Merb::Fixtures::Fixture::
  #   Fixture for given model with given name.
  # 
  # ==== Example
  # fixture_for Author, :botanicus do
  #   self.first_name = Jakub
  #   self.last_name = Šťastný
  # end
  # - 
  # @public
  def fixture_for(klass, name, &block)
    include Merb::Fixtures::Helpers if Merb::Plugins.config[:fixtures]
    instance = klass.new # Post.new
    instance.instance_eval(&block) if block_given?
    klass.fixture.create(name, instance)
    return instance
  end
  
  # Great for test/spec:
  # Load answer.rb fixture:
  # fixture(:answer)
  # fixture(:answer, :ruby)
  def load_fixtures(fixture)
    load Merb::Plugins.config[:fixtures][:directory] / fixture.to_s / ".rb"
  end
end