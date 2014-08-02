require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
        it "sould have the right title" do
      get :new
      response.should have_selector("title" , 
                                    :content =>"Sing in")
    end
  end
  describe "'POST' create" do
    describe "failure" do
      before(:each) do
        @attr = {:email => "", :password => ""}
      end
      it "should re-render the new page" do
        post :create, :session => @attr
        response.should be_success 
      end
      it "should re-render the new page/render_template" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      it "should have an error message" do
        post :create, :session => @attr
        flash.now[:error].should =~/Invalid/i
      end
      it "should have the rigth title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sing in")
      end
    end
  end
  describe "success" do
    before(:each) do
      @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "ashera.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
      @attr = {:email => @user.email, :password =>@user.password}                          
    end
    it  "should sign the user in" do
      post :create, :session => @attr
      controller.should be_signed_in
      controller.current_user.should == @user
    end
    it "should redirect to the user show page" do
      post :create, :session => @attr
      response.should redirect_to(user_path(@user))
    end
    
    it "should current user  == @user" do
      post :create, :session => @attr
      controller.current_user.should == @user
    end
    describe "DELETE 'destroy'" do
    it "should the user log-out" do
      test_sign_in(@user)
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
    end
  end
 
end








