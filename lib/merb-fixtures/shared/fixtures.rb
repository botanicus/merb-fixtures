module Merb
  module Fixtures
    def self.load
      Merb.logger.debug("Loading fixtures ...")
      unless Merb.env?("production")
        directory = Merb::Plugins.config[:fixtures][:directory]
        if File.exist?(directory)
          Dir[directory / "*.rb"].each do |file|
            # It's important to not use just load, remember the namespace
            Kernel.load(file)
          end
        else
          raise FixturesDirectoryNotFound
        end
      end
    end
    
    def self.reload
      self.load
    end
    
    def self.all
      models = ORM.models
      models.map! { |model| model.fixtures unless model.fixtures.empty? }
      return models.compact.flatten
    end
    
    def self.save_all
      Merb::Fixtures.all.each { |fixture| fixture.save }
    end
  end
end