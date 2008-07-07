# generic interface to misc. ORMs
module Merb
  module Fixtures
    module ORM
      def self.models
        ObjectSpace.each_object(Class) do |klass|
          case ORM
          when :datamapper
            if klass.included_modules.include?(DataMapper::Resource)
              models.push(klass)
            end
          when :sequel
            if klass < Sequel::Model
              models.push(klass)
            end
          when :activerecord
            if klass < ActiveRecord::Base
              models.push(klass)
            end
          end
        end
      end
    end
  end
end