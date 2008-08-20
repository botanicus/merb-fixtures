# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task "db:fixtures:reload" => ["db:create", "db:migrate", "db:fixtures:load"]