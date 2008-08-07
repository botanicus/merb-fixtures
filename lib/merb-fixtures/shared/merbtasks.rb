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
# @semipublic
def taskname(name)
  case Merb.orm_generator_scope
  when :datamapper   : "dm:db:fixtures:#{name}"
  when :sequel       : "sequel:db:fixtures:#{name}"
  when :activerecord : "db:fixtures:#{name}"
  end
end

desc "Load the fixtures into database"
task taskname(:load) => :merb_env do
  Merb::Fixtures.load
  Merb::Fixtures.save
end