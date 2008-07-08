desc "Load the fixtures into database"
task Merb::Fixtures.task(:load) => :merb_env do
  Merb::Fixtures.all.each do |fixture|
    if fixture.save
      puts "~ #{fixture.class} saved ..."
    else
      puts "#{fixture.class} couldn't be saved ..."
      puts fixture.errors.each { |error| puts error }
    end
  end
end