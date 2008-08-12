module Merb
  module Fixtures
    class << self
      def load
        Merb.logger.debug("Loading fixtures ...")
        unless Merb.env?("production")
          directory = Merb::Plugins.config[:fixtures][:directory]
          if File.exist?(directory)
            Dir[directory/"*.rb"].each do |file|
              # It's important to not use just load, remember the namespace
              Kernel.load(file)
            end
          else
            raise FixturesDirectoryNotFound
          end
        end
      end

      alias :reload :load
      
      def self.all
        ORM.models.map { |model| model.fixtures unless model.fixtures.empty? }.compact.flatten
      end

      def self.save
        Merb::Fixtures.all.each { |fixture| fixture.save }
      end
    end
  end
end