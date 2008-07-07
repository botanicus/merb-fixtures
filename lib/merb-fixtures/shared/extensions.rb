require "merb-fixtures/shared/fixture"

module Merb
  module Fixtures
    module Extensions
      def self.included(base)
        base.extend(ClassMethods)
      end
    
      module ClassMethods
        # Get fixture:
        # Post.fixture(:botanicus)
        # Create fixture:
        # Post.fixture.create(:botanicus, Author.new)
        def fixture(name = nil)
          @fixture ||= Merb::Fixtures::Fixture.new
          name ? @fixture.load(name) : @fixture
        end
      
        # Post.fixtures => [#<Post...>, ...]
        def fixtures
          @fixture ||= Merb::Fixtures::Fixture.new
          return @fixture.objects
        end
      end
    end
  end
end