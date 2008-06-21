# Better will be creating one instance per object (one for Post, one for Author ... )
class Fixture
  def initialize
    @fixtures = Hash.new
  end

  # Fixture.create(:botanicus, Author.new)
  def create(name, object)
    @fixtures[name] = object
  end

  # Fixture.load(:botanicus)
  def load(name)
    return @fixtures[name] #rescue nil
  end
  
  def objects
    @fixtures.values
  end
end

module DataMapper
  module Resource
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Get fixture:
      # Post.fixture(:botanicus)
      # Create fixture:
      # Post.fixture.create(:botanicus, Author.new)
      def fixture(name = nil)
        @fixture ||= ::Fixture.new # tu bude pruser
        name ? @fixture.load(name) : @fixture
      end
      
      # Post.fixtures => [#<Post...>, ...]
      def fixtures
        @fixture ||= ::Fixture.new
        return @fixture.objects
      end
    end
  end
end