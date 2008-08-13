require "merb-fixtures/shared/fixture"

module Merb
  module Fixtures
    module Extensions
      def self.included(base)
        base.extend(ClassMethods)
      end
    
      module ClassMethods
        # Post.fixture(:botanicus)
        def fixture(name)
          self.init
          name ? @fixture.load(name) : @fixture
        end
        
        # Post.get_fixture.create(:botanicus, Author.new)
        def get_fixture
          self.init
          return @fixture
        end
      
        # Post.fixtures => {:name => object}
        def fixtures
          self.init
          return @fixture
        end
        
        protected
        def init
          @fixture ||= Merb::Fixtures::Fixture.new
        end
      end
    end
  end
end