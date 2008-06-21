require File.dirname(__FILE__) + '/../spec_helper'
require "merb-fixtures/fixture"

describe Fixture do
  before(:each) do
    @fixture = Fixture.new
    @botanicus = mock("Botanicus")
  end
  
  it "should create new fixture" do
    @fixture.create(:other_author, @botanicus)
    @fixture.load(:other_author).should eql(@botanicus)
  end
  
  describe "#load" do
    before(:each) do
      @fixture.create(:botanicus, @botanicus)
    end

    it "should load existing fixture" do
      @fixture.load(:botanicus).should eql(@botanicus)
    end
    
    it "should returns nil if fixture doesn't exist" do
      @fixture.load(:non_existing_author).should be_nil
    end
  end
  
  describe "#objects" do
    before(:each) do
      @another = mock("Another Author")
      @botanicus.should_receive(:<=>).with(@another).any_number_of_times.and_return(1)
      @another.should_receive(:<=>).with(@botanicus).any_number_of_times.and_return(-1)
    end

    it "should returns empty array by default" do
      @fixture.objects.should eql(Array.new)
    end
    
    it "should return all instance's fixtures" do
      @fixture.create(:botanicus, @botanicus)
      @fixture.create(:another,   @another)
      @fixture.objects.should eql([@botanicus, @another].sort)
    end
  end
end