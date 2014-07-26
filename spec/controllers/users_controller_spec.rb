require 'spec_helper'
#require 'factories.rb'
#require 'factory_girl_rails'



 describe UsersController do
  render_views
  
  describe "GET 'show'" do
     before(:each) do
      #    @user = Factory(:user)
      #    @user = FactoryGirl(:User)
       @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
                           
      end
      
    it "should be successful" do
      get :show , :id => @user
      response.should be_success
    end
    it "should find the writ user" do
      get :show , :id =>@user
      assigns(:user).should == @user
    end
  end
  
  
 describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    it "sould have the right title" do
      get :new
      response.should have_selector("title" , 
                                    :content =>"Sign up")
    end
  end

end
