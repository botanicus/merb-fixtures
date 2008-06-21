require File.dirname(__FILE__) + '/../spec_helper'
require "fixture"

# Mock object
class Author
  attr_reader :created_at
  def initialize
    @created_at = Time.now
  end
  
  def <=>(other)
    self.created_at <=> other.created_at
  end
end

describe Fixture do
  before(:each) do
    @author  = Author
    @fixture = Fixture.new
  end
  
  it "should create new fixture" do
    @fixture.create(:other_author, @author)
    @fixture.load(:other_author).should eql(@author)
  end
  
  describe "#load" do
    before(:each) do
      @fixture.create(:botanicus, @author)
    end

    it "should load existing fixture" do
      @fixture.load(:botanicus).should eql(@author)
    end
    
    it "should returns nil if fixture doesn't exist" do
      @fixture.load(:non_existing_author).should be_nil
    end
  end
  
  describe "#objects" do
    it "should returns empty array by default" do
      @fixture.objects.should eql(Array.new)
    end
    
    it "should return all instance's fixtures" do
      botanicus = @author.new
      another = @author.new
      @fixture.create(:botanicus, botanicus)
      @fixture.create(:another,   another)
      @fixture.objects.should eql([botanicus, another].sort)
    end
  end
end