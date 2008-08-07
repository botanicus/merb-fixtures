# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task taskname(:reload) => ["dm:db:automigrate", "dm:db:migrate:up", "dm:db:fixtures:load"]