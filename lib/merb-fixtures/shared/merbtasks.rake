desc "Load the fixtures into database"
task Merb::Fixtures.task(:load) => :merb_env do
  Merb::Fixtures.save_all
end