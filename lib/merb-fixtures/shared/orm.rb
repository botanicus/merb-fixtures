module ObjectSpace
  def self.each_class(&block)
    ObjectSpace.each_object(Class) do |klass|
      block.call(klass) if block_given?
    end
  end
end

module Merb
  module Fixtures
    module ORM
      def self.models
        models = Array.new
        case ::ORM
        when :datamapper
          ObjectSpace.each_class do |klass|
            if klass.included_modules.include?(DataMapper::Resource)
              models.push(klass)
            end
          end
        when :sequel
          ObjectSpace.each_class do |klass|
            if klass < Sequel::Model
              models.push(klass)
            end
          end
        when :activerecord
          ObjectSpace.each_class do |klass|
            if klass < ActiveRecord::Base
              models.push(klass)
            end
          end
        end
        return models
      end
      
      def self.task(taskname)
        case ::ORM
        when :datamapper   : "dm:db:fixtures:#{taskname}"
        when :sequel       : "sequel:db:fixtures:#{taskname}"
        when :activerecord : "db:fixtures:#{taskname}"
        end
      end
    end
  end
end