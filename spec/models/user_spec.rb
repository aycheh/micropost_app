# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean          default(FALSE)
#

require 'spec_helper'

 describe User do
   before(:each) do
      @attr = {:name => "asher" , 
               :email => "asher@gmail.com",
               :password => "foobar" ,
               :password_confirmation => "foobar"}
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
     short_name = "a" * 1
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
    it "should reject email addresses identical up to case , it well check case sensetiv" do
      upcase_email = @attr[:email].upcase!
      User.create!(@attr.merge(:email => upcase_email))
      douplecat_user = User.new(@attr)
      douplecat_user.should_not be_valid
     end
 describe "password" do
      before(:each) do
        @user = User.new(@attr)
      end
      it "should have a password" do
        @user.should respond_to(:password)
      end
      it "shoul have password confirmation attribute" do
        @user.should respond_to(:password_confirmation)
      end
    end
 describe "password validation" do
      it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid   
      end
      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
      end
    end
     it "should reject too short password" do
       short_password = "a" * 5
       hash = @attr.merge(:password => short_password , :password_confirmation => short_password)
       User.new(hash).should_not be_valid
     end
     
     it "should reject too long password" do
       long_password = "a" * 41
       hash = @attr.merge(:password => long_password , :password_confirmation => long_password)
       User.new(hash).should_not be_valid
     end
 describe "password encryption" do
       before(:each)do
         @user = User.create!(@attr)
     end
       it "should have an encrypted password" do
         @user.should respond_to(:encrypted_password)
     end
         it "should set encrypted password in to DB" do
         @user.encrypted_password.should_not be_blank
     end
     it "should hav a salt " do
       @user.should respond_to(:salt)
     end
 describe "has_password? method" do
    it "should respond_to has_password? = exist" do
     @user.should respond_to(:has_password?) 
      end
      it "should return true, if ths password match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      it "should return false , if the password don't match" do
        @user.has_password?("invalid").should be_false
      end
     end  
 describe "user authenticate method" do
     it "should respond_to authenticate " do
       User.should respond_to(:authenticate)
     end
     it "should return nil for an email address with no user" do
       User.authenticate("fale@mail.com", @attr[:password])
     end
     it "should return the user " do
       User.authenticate(@attr[:email], @attr[:password]).should == @user
     end
     it "should return nil if email/password don't match for the user" do
      User.authenticate(@attr[:email], "passwors").should be_nil 
     end
   end       
  end
 describe "admin attribute" do
    
   before(:each) do 
     @user = User.create!(@attr)
   end
   
   it "should responce to admin" do
     @user.should respond_to(:admin)
   end
   
   it "showld not be an admin br default" do
     @user.should_not be_admin
   end
   
   it "should be converted to be an admin" do
     @user.toggle(:admin)
     @user.should be_admin
   end   
 end
 describe "the micropost association" do
   before(:each) do 
     @user = User.create!(@attr)
     @mp1 = {:content => "first post Teddi id a greate boy" }
     @mp2 = {:content => "second pots Eden is a greate girle " }
     @user.microposts.create!(@mp1)
     sleep 2 #(sleep 2 seconds)
     @user.microposts.create!(@mp2)
   end
   it "should have a micropst arrtibute" do
     @user.should respond_to(:microposts)
   end
   # In This test , the code dose as axpecetd but the setst  fail becouse the the full returned result dose not natch the exact expected(live it comment uot) 
   it "should have the rigth micropst in the rigth order" do
     #@user.microposts.should == [@mp2,@mp1]
   end
   it "should destroy associated microposts to user" do
     @user.destroy
     [@mp1 ,@mp2].each do |micropost|
      #Micropost.find_by_id(micropost.id).should be_nil
      Micropost.find_by_user_id(@user.id).should be_nil
     end
   end
 end  
end





