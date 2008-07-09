require File.dirname(__FILE__) + '/../../spec_helper'
require "merb-fixtures/shared/orm"

describe Merb::Fixtures::ORM do
  include SpecHelper
  before(:all) do
    models :datamapper,   "Author",  "Post"
    models :activerecord, "Content", "User"
    models :sequel,       "Update",  "Tag"
  end

  describe "::models" do
    it "should returns all DataMapper models" do
      Merb::Fixtures::ORM.models(:datamapper).should eql([Post, Author])
    end

    it "should returns all ActiveRecord models" do
      Merb::Fixtures::ORM.models(:activerecord).should eql([User, Content])
    end

    it "should returns all Sequel models" do
      Merb::Fixtures::ORM.models(:sequel).should eql([Tag, Update])
    end
  end
  
  describe "::tasks" do
    it "should returns correct name of DataMapper task" do
      Merb::Fixtures::ORM.task(:load, :datamapper).should eql("dm:db:fixtures:load")
    end

    it "should returns correct name of ActiveRecord task" do
      Merb::Fixtures::ORM.task(:load, :activerecord).should eql("db:fixtures:load")
    end

    it "should returns correct name of Sequel task" do
      Merb::Fixtures::ORM.task(:load, :sequel).should eql("sequel:db:fixtures:load")
    end
  end
end