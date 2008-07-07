# FIXME: find better way how to do it. Problems: when user add a model, he must restart his application.
require "merb-fixtures/shared/orm"
Merb::Fixtures::ORM.models.each do |model|
  model.send(:include, Merb::Fixtures::Extensions)
end