require File.dirname(__FILE__) + '/../spec_helper'
require "merb-fixtures/datamapper"

# FIXME: MOVE TO EXTENSIONS
# Mock object
class Author
  attr_reader :created_at
  include DataMapper::Resource
  def initialize
    @created_at = Time.now
  end
end

describe "<model>" do
  before(:each) do
    @botanicus = Author.new
    @fixtures  = Array(@botanicus)
    Author.fixture.create(:botanicus, @botanicus)
  end
  
  describe ".fixture" do
    it "should returns Fixture instance if no argument given" do
      Author.fixture.should be_instance_of(Fixture)
    end
    
    it "should returns unique instance" do
      one = Author.fixture(:botanicus)
      two = Author.fixture(:botanicus)
      one.object_id.should eql(two.object_id)
    end
    
    it "should returns fixture object if argument with its name is given" do
      Author.fixture(:botanicus).should eql(@botanicus)
    end
  end
  
  describe ".fixtures" do
    it "should returns fixtures objects" do
      Author.fixtures.should eql(@fixtures)
    end
  end
end