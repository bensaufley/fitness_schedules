require 'spec_helper'

describe "Static Pages" do

  describe "Home Page" do
    before { visit root_path }
    page.should have_selector('title', content: "Fitness Schedules")
  end

end