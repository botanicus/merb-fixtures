# Better will be creating one instance per object (one for Post, one for Author ... )
class Fixture
  def initialize
    @fixtures = Hash.new
  end

  # Fixture.create(:botanicus, Author.new)
  def create(name, object)
    @fixtures[name] = object
  end

  # Fixture.load(:botanicus)
  def load(name)
    return @fixtures[name] #rescue nil
  end
  
  # FIXME: has DM objects <=> ?
  def objects
    @fixtures.values.sort
  end
end