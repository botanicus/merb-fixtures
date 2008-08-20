# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task "sequel:db:fixtures:reload" => ["sequel:db:migrate", "sequel:db:fixtures:load"]