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
  # Do NOT use this in your fixture files!
  def load_fixtures(*fixtures)
    do_some_with_fixtures do |directory, fixture|
      load directory / fixture
    end
  end
  
  # Use it in your fixture files
  def require_fixtures(*fixtures)
    do_some_with_fixtures do |directory, fixture|
      require directory / fixture
    end
  end
  
  private
  def do_some_with_fixtures(fixtures, &block)
    fixtures.each do |fixture|
      directory = Merb::Plugins.config[:fixtures][:directory]
      fixture   = "#{fixture}.rb"
      block.call(directory, fixture)
    end
  end
end