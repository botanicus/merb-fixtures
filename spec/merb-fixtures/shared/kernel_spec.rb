require File.dirname(__FILE__) + '/../spec_helper'
require "merb-fixtures/kernel"
require "merb-fixtures/fixture"

describe Kernel do
  before(:each) do
    @author    = mock("Author")
    @botanicus = mock("Botanicus")
    @fixture   = lambda { fixture_for(@author, :botanicus) }
    @author.should_receive(:new).any_number_of_times.and_return(@botanicus)
    @author.should_receive(:fixture).any_number_of_times.and_return(Fixture.new)
  end
  
  it "should returns model object" do
    @fixture.call.should eql(@botanicus)
  end
end