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
      response.should have_selector('td>a', :content => user_path(@user),
                                            :href    => user_path(@user) )
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
  describe "POST 'create'" do
     describe "failure" do
       before(:each) do
          @attr = {:name => "" , :email => "", 
                 :password => "", 
                 :password_confirmation => ""}
       end
        it "should have the right title " do
         post :create , :user => @attr
         response.should have_selector("title", 
                                       :content => "Sign up")
        end
        it "should render the new page" do
          post :create , :user => @attr
          response.should render_template('new')
        end
        it "should not create a user" do
          lambda do
            post :create , :user => @attr
          end.should_not change(User, :count)
        end
     end
  describe "seccess" do
     before(:each) do
          @attr = {:name => "new user" , :email => "new@user.com", 
                 :password => "foobar", 
                 :password_confirmation => "foobar"}
       end
       it "should create user" do
         lambda do
           post :create,  :user => @attr
         end.should change(User, :count).by(1)
       end
       it "should redirect to the user show page" do
         post :create,  :user => @attr
         response.should redirect_to(user_path(assigns(:user)))
       end
       it "should show a flash wellcome message" do
         post :create,  :user => @attr
         flash[:success].should =~ /wellcome to micropost app/i
         
       end
     end  
  end
  describe "GET  'edit" do
    before(:each) do
      @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
    test_sign_in(@user)
    end
    it "should be successful" do
      get :edit , :id => @user
      response.should be_success
    end
    it "should have the rigth title" do
      get :edit , :id => @user
      response.should have_selector('title', :content => "Edit user")
    end
    it "should have a link to gange the Gravatar" do
      get :edit , :id => @user
      response.should have_selector('a', :href =>"http://www.gravatar.com/emails",
                                         :content => "change")
    end
  end
  describe "PUT 'update'" do
      before(:each) do
        @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
      test_sign_in(@user)
      end
    describe "update failure" do
      before(:each) do 
        @attr = {:name => "" , :email => "", 
                 :password => "", 
                 :password_confirmation => ""}
      end
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attrr
        response.should render_template('edit')
      end
      it "should hsve the rigth title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector('title', :content =>"Edit user")
      end
    end
   describe "update success" do
     before(:each) do 
        @attr = {:name => "new name",
                 :email => "asher.aycheh@gmail.net", 
                 :password => "foobar11", 
                 :password_confirmation => "foobar11"}
       
      end
      it "should change the user attribute" do
        put :update, :id => @user, :user => @attr
        user = assigns(:user) 
        @user.reload
        #@user.name.should == user.name
        @user.email.should == user.email 
      end
      it "should change the user attribute " do
        put :update, :id => @user, :user => @attr
        user = assigns(:user) 
        @user.reload 
        @user.name.should == user.name
      end
      it "should have a flash seccess message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated successfuly/i
      end
   end
  end
end












