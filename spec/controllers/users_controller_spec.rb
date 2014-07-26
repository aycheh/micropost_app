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
    it "should find the right user" do
      get :show , :id =>@user
      assigns(:user).should == @user
    end
    it "show the right title" do
      get :show ,:id => @user
      response.should have_selector('title', :content =>@user.name)
    end
    
    it "should have the user's name in the <h1> " do
      get :show ,:id => @user
      response.should have_selector('h1', :content =>@user.name)
    end
    it "should have the profile name in the <h1> " do
      get :show ,:id => @user
      response.should have_selector('h1>img', :class =>"gravatar")
    end
    it "should have the rigth URL " do
      get :show ,:id => @user
      response.should have_selector('h1>a', :content => user_path(@user),
                                            :href    => user_path(@user) )
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
