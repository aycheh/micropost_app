require 'spec_helper'


describe PagesController do
  render_views

  
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    it "sould have the right title" do
      get 'home'
      response.should have_selector("title" , :content =>"Ruby On Rails tutorial micropost_app | home")
    end
    it "sould have the <h1> tag" do
      get 'home'
      response.should have_selector('h1')
    end
    it "sould have a non-blank body" do
      get 'home'
      response.body.should_not =~ /<body>\s*<\/body>/
    end
    
    
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    it "sould have the right title" do
      get 'contact'
      response.should have_selector("title" , :content =>"Ruby On Rails tutorial micropost_app | contact")
    end
  end
  
  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    it "sould have the right title" do
      get 'about'
      response.should have_selector("title" , :content =>"Ruby On Rails tutorial micropost_app | about")
    end
  end

end
