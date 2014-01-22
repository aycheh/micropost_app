require 'spec_helper'

 describe "LayoutLinks" do
  # describe "GET /layout_links" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get layout_links_index_path
      # response.status.should be(200)
    # end
   #end
   it "should have a home page at '/" do
      get '/'
      response.should have_selector('title' , :content => "home")
    end
    
    it "should have a contact page at '/contact" do
      get '/contact'
      response.should have_selector('title' , :content => "contact")
    end
    
    it "should have a about page at '/about" do
      get '/about'
      response.should have_selector('title' , :content => "about")
    end
    
      it "should have a help page at '/help" do
       get '/help'
       response.should have_selector('title' , :content => "help")
     end
     
     it "should have a Sign up page at '/signup" do
       get '/signup'
       response.should have_selector('title' , :content => "Sign up")
     end
     
     it "should have the rigth links on the layout" do
       visit root_path
       response.should have_selector('title', :content => "home")
       
       click_link "about"
       response.should have_selector('title', :content => "about")
       
       click_link "contact"
       response.should have_selector('title', :content => "contact")
       
       click_link "home"
       response.should have_selector('title', :content => "home")
       
       click_link "Sign up now!"
       response.should have_selector('title', :content => "Sign up")
       response.should have_selector('a[href="/"]>img')
     end
    
end
