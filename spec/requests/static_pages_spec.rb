require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the h1 content 'PhotoBlog'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'PhotoBlog')
    end

    it "should have the title 'Home'" do
    	visit '/static_pages/home'
    	page.should have_selector('title', :text => "PhotoBlog | Home")
    end
  end

  describe "Help page" do

    it "should have the h1 content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Help'" do
    	visit '/static_pages/help'
    	page.should have_selector('title', :text => 'PhotoBlog | Help')
    end
  end

  describe "About page" do

    it "should have the h1 content 'About'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About')
    end

    it "should have the title 'About'" do
    	visit '/static_pages/about'
    	page.should have_selector('title', :text => 'PhotoBlog | About')
    end
  end
end		