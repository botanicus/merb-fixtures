require "merb-fixtures/fixture"

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