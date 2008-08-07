puts(">>> #{__FILE__} <<<")
# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task Merb::Fixtures::ORM.task(:reload) => ["dm:db:automigrate", "dm:db:migrate:up", "dm:db:fixtures:load"]