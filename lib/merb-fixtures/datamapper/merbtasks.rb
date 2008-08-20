# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task "dm:db:fixtures:reload" => ["dm:db:automigrate", "dm:db:migrate:up", "dm:db:fixtures:load"]