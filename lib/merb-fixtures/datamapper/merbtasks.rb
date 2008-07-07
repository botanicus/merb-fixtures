desc "Load the fixtures into database"
task "dm:db:fixtures:load" => :merb_env do
  Fixture.all.each do |fixture|
    if fixture.save
      puts "~ #{fixture.class} saved ..."
    else
      puts "#{fixture.class} couldn't be saved ..."
      puts fixture.errors.each { |error| puts error }
    end
  end
end

# Reload tasks
desc "Reload the fixtures from database. Warning: it recreate the database!"
task "dm:db:fixtures:reload" => ["dm:db:automigrate", "dm:db:migrate:up", "dm:db:fixtures:load"]