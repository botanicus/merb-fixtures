# Better will be creating one instance per object (one for Post, one for Author ... )
require "merb-fixtures/shared/orm"

module Merb
  module Fixtures
    class Fixture
      # FIXME: isn't better to have it as hash?
      def self.all
        models = ORM.models
        models.map! { |model| model.fixtures unless model.fixtures.empty? }
        return models.compact.flatten
      end

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
  end
end