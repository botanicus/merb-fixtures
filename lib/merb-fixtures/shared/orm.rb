require "merb-fixtures/extensions/object_space"

module Merb
  module Fixtures
    module ORM
      # Get array of model classes.
      # 
      # ==== Parameters
      # orm<Symbol>::
      #   Name of ORM. The ORM choosen in use_orm is used by default.
      #   Possibilities: :datamapper, :activerecord or :sequel
      #
      # ==== Returns
      # Array[Class]:: Array of model classes.
      # 
      # @public
      def self.models(orm = ::ORM)
        models = Array.new
        case orm
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
      
      # Get name of rake task
      # 
      # ==== Parameters
      # taskname<Symbol>::
      #   Name of task. For example :load.
      # orm<Symbol>::
      #   Name of ORM. The ORM choosen in use_orm is used by default.
      #   Possibilities: :datamapper, :activerecord or :sequel
      #
      # ==== Example
      # Merb::Fixtures::ORM.task(:load) => dm:db:fixtures:load # Default ORM was DataMapper
      # Merb::Fixtures::ORM.task(:load, :sequel) => sequel:db:fixtures:load
      # 
      # ==== Returns
      # String:: Name of task. For example dm:db:fixtures:load
      # 
      # @public
      def self.task(taskname, orm = ::ORM)
        case orm
        when :datamapper   : "dm:db:fixtures:#{taskname}"
        when :sequel       : "sequel:db:fixtures:#{taskname}"
        when :activerecord : "db:fixtures:#{taskname}"
        end
      end
    end
  end
end