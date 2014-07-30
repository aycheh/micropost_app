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
      it " " do
        post :create, :session => @attr
        flash.now[:error].should =~/Invalid/
      end
      it "should have the rigth title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sing in")
      end
    end
  end
  describe "seccess" do
    before(:each) do
      @user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
      @attr = {:email => @user.email, :password =>@user.password}                          
    end
    it "should the user sign in" do
      post create, :session => @attr
      controller.should be_signed_in
      controller.current_user.should == @user
    end
    it "should redirect to user show page" do
      post create, :session => @attr
      response.should redirect_to(user_path(@user))
    end
  end
    
end










