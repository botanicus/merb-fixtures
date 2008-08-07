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
      # @semipublic
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
    end
  end
end