require 'spec_helper'

describe "Static Pages" do

  describe "Home Page" do
    before { visit root_path }
    
    it "Should have proper title" do 
      page.should have_selector('title', content: "Fitness Schedules") 
      page.should have_selector('h1', content: "Home Page" ) 
    end
    
    it "Should have the header and footer" do
      page.should have_selector('h3', content: "footer")
      page.should have_selector('h3', content: "header")
    end
              
  end

end