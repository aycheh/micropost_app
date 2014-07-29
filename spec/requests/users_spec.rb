require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get users_index_path
      # response.status.should be(200)
    # end
    describe "Sign up failure for user " do
      it "should not create new user" do
      lambda do
       visit signup_path
        fill_in "Name",     :with => ""
        fill_in "Email",     :with => ""
        fill_in "Password",     :with => ""
        fill_in "Confirmation",     :with => ""
        click_button
        response.should render_template('users/new')
        response.should have_selector('div#error_explanation')
      end.should_not change(User, :count)
      end
    end
  end
  describe "Sign up success for user" do
      describe "seccess" do
        it "should create new user" do
          lambda do
        visit signup_path
        fill_in "Name",             :with => "test"
        fill_in "Email",            :with => "test@test.com"
        fill_in "Password",         :with => "foobar"
        fill_in "Confirmation",     :with => "foobar"
        click_button
        response.should render_template('users/new')
        #response.should have_selector('div#flash.success' , :content => "wellcome")
        end.should change(User, :count).by(1)
      end
      end
    end
end
