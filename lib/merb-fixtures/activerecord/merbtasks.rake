# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task Merb::Fixtures.task(:load) => ["db:create", "db:migrate", "db:fixtures:load"]