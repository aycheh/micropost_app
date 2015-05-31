require 'spec_helper'
#require 'factories.rb'
#require 'factory_girl_rails'
 describe UsersController do
  render_views
  
 describe "GET 'index' " do
   describe "for non-signed-in users " do
     it "should deny access " do
       get :index
       response.should redirect_to(signin_path)
     end
   end
   
 describe "for signed-in users" do
     before(:each) do
       user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
       @user = test_sign_in(user)
       user_1 = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.user_1@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
                          
       user_2 = User.create!(
                          :name => "asher ayche" , 
                          :email => "user_2@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
                          
     end
     it "should be successful" do
       get :index 
       response.should be_success
     end
     it "should have the right title " do
       get :index 
       response.should have_selector("title" , :content => "All users")
     end
     it "should have an element of each user" do
       get :index 
       User.all.each do |user|
          response.should have_selector("li" ,:content => user.name)
        end
      end 
      it "should have a delete link for admin" do
         @user.toggle!(:admin)
         other_user = User.all.second
         get :index 
         response.should have_selector('a', :href => user_path(other_user),
                                            :content => "delete")
       end
      it "should not have a delete link for non-admin" do
        other_user = User.all.second
        get :index 
        response.should_not have_selector('a', :href => user_path(other_user),
                                            :content => "delete")
      end
   end
 end 
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
     it "shows the users microposts" do
       
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
        @user.name.should == user.name && @user.email.should == user.email 
          
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
 describe "authentication of edit/update action" do
    before(:each) do
        @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
      end
      
  describe "nun-signed-in users " do 
    it "should deny access to 'edit" do
        get :edit , :id => @user
        response.should redirect_to(signin_path)
        flash[:notice].should =~/sign in/i
      end
    it "should deny access to 'update" do
        put :update, :id => {} #@user
        response.should redirect_to(signin_path)
      end
   end
  end
 describe "for-signin users" do 
    before(:each) do
     @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
     
      @wrong_user = User.create!(
                          :name => "asher ayche" , 
                          :email => "wrong_user@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
     
     
      test_sign_in(@user)
    end
    it "should require matching users for 'edit' " do
     get :edit , :id => @wrong_user
     response.should redirect_to(root_path)
    end
    
    it "should require matching users for 'update' " do
     put :update , :id => @wrong_user
     response.should redirect_to(root_path) 
    end
  end
  
 describe "DELETE 'destroy'" do
   before(:each) do
     @user = User.create!(
                           :name => "asher ayche" , 
                           :email => "wrong_user@gmail.com" , 
                           :password => "foobar1" , 
                           :password_confirmation => "foobar1")
     
   end
  
   describe "non-sign-in user " do
      it " should deny access " do
      delete :destroy ,:id =>  @user
      response.should redirect_to(signin_path)  
      end   
    end 
   end
 describe "as non-admin user" do
     it " should deny access " do
     @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
     test_sign_in(@user) 
     delete :destroy ,:id =>  @user
     response.should redirect_to(root_path)  
     end   
    end 
 describe "as non-admin user" do
      before(:each) do 
      @admin = User.create!(
                           :name => "asher ayche" , 
                           :email => "admin@gmail.com" , 
                           :password => "foobar1" , 
                           :password_confirmation => "foobar1",
                           :admin => true)
     @user = User.create!(
                           :name => "asher ayche" , 
                           :email => "asher.aycheh@gmail.com" , 
                           :password => "foobar1" , 
                           :password_confirmation => "foobar1")
      test_sign_in(@admin)  
      end
      it "should destroy the user " do
        lambda do
            delete :destroy,  :id => @user
          end.should change(User, :count).by(-1) 
      end
      it "should redirect to users page" do
        delete :destroy , :id => @user
      end
      it "shoul not destroy itself" do
        lambda do
        delete :destroy ,:id => @admin
        end.should_not change(User , :count)
      end
    end
 describe "GET 'show'" do   
 describe "users microposts" do
   before(:each) do 
    @user_attr = {:name => "asher" , 
                  :email => "asher@gmail.com",
                  :password => "foobar" ,
                  :password_confirmation => "foobar"}
    @user = User.create!(@user_attr)
    @post_attr_1 = {:content => "lorem ipsum first " }
    @post_attr_2 = {:content => "lorem ipsum second" }
  end
  it "should shows the user's microposts" do
     mp1 = @user.microposts.create!(@post_attr_1)
     mp2 = @user.microposts.create!(@post_attr_2)
     get :show, :id => @user
     response.should have_selector('span.content', :content => mp1.content)
     response.should have_selector('span.content', :content => mp2.content)
  end
 end
end
end













