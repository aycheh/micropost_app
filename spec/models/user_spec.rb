require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "asher" , :email => "asher@gmail.com"}
  end
  it "should create new instance/('User.create! =>'new user) given a valid attribute" do
    User.create!(@attr)
  end
  it "should require a name " do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  it "should require an email address " do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  it "should rejacet name that are too long" do
    long_name = "a" * 51
    long_name = User.new(@attr.merge(:name => long_name))
    long_name.should_not be_valid
  end
  it "should rejacet name that are too short" do
  short_name = "a" * 2
  short_name = User.new(@attr.merge(:name => short_name))
  short_name.should_not be_valid
  end
  it "should accapt valid email addresses" do
    addresses = %w[asher.ayche@gmail.com asher@gmail.net asher@foo.bar.org foo_1@foo.il]
    addresses.each do |address|
    valid_email_user = User.new(@attr.merge(:email => address))
    valid_email_user.should be_valid
   end
  end
  it "should not accapt invalid email addresses" do
    addresses = %w[asher.ayche.gmail.com asher@gmail_net asher@foo.bar. @foo.il]
    addresses.each do |address|
    invalid_email_user = User.new(@attr.merge(:email => address))
    invalid_email_user.should_not be_valid
   end
  end
  it "should reject duplicate email addresses" do
    old_user = User.create!(@attr)
    new_user = User.new(@attr)
    new_user.should_not be_valid
  end
end
