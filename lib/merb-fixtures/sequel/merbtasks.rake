# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task Merb::Fixtures.task(:load) => ["sequel:db:migrate", "sequel:db:fixtures:load"]