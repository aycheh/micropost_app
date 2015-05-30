# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Micropost do
#  pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do 
    @user_attr = {:name => "asher" , 
                  :email => "asher@gmail.com",
                  :password => "foobar" ,
                  :password_confirmation => "foobar"}
    @user = User.create!(@user_attr)
    @post_attr = {:content => "lorem ipsum " }
  end
  it "should create a new instance with valid attributes" do
    @user.microposts.create!(@post_attr)
  end
  describe "user associations" do
    before(:each) do
      @micropost = @user.microposts.create(@post_attr)
    end
    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end
    it "shold have the rigth assiciated user" do
      @micropost.user_id == @user.id
    end
    it "shold have the rigth assiciated micropost " do
      @micropost.user == @user
    end
  end
end
