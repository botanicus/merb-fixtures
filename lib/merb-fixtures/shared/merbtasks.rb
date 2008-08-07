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