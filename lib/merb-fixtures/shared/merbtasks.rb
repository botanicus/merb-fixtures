puts(">>> #{__FILE__} <<<")
desc "Load the fixtures into database"
task Merb::Fixtures::ORM.task(:load) => :merb_env do
  Merb::Fixtures.save_all
end