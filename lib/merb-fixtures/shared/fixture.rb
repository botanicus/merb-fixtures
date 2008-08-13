require "merb-fixtures/shared/orm"

module Merb
  module Fixtures
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
        @fixtures
      end
    end
  end
end