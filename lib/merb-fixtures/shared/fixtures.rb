module Merb
  module Fixtures
    class << self
      def load
        Merb.logger.debug("Loading fixtures ...")
        unless Merb.env?("production")
          directory = Merb::Plugins.config[:fixtures][:directory]
          if File.exist?(directory)
            Dir[directory/"*.rb"].each do |file|
              Kernel.load(file)
            end
          else
            raise FixturesDirectoryNotFound
          end
        end
      end

      alias :reload :load
      
      def all
        output = Hash.new
        ORM.models.each { |model| output.merge!(model.fixtures) unless model.fixtures.values.empty? }
        return output
      end
      
      def save
        Merb::Fixtures.all.each { |name, fixture| fixture.save rescue raise "Fixture #{name} (model #{fixture.class}) couldn't be saved!"}
      end
    end
  end
end