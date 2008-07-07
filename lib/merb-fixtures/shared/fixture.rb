# Better will be creating one instance per object (one for Post, one for Author ... )
module Merb
  module Fixtures
    class Fixture
      def self.all
        models = Array.new
        ObjectSpace.each_object(Class) do |klass|
          if klass.included_modules.include?(DataMapper::Resource)
            models.push(klass)
          end
        end
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