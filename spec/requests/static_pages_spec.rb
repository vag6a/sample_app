require 'rails_helper'

RSpec.describe "Static Pages", :type => :model do

    describe "Home page" do
        it "Should have content 'Sample App'" do
            visit  '/static_pages/home'
            page.should have_selector('h1', :text => 'Sample App')
        end
        it "should have the right title" do
            visit  '/static_pages/home'
            page.should have_selector('title', :text => "Ruby on rails Tutorial Sample App| Home")
        end
    end 

    describe "Help page" do
        it "Should have content 'Help'" do
            visit  '/static_pages/help'
            page.should have_selector('h1', :text => 'Help')
        end
        it "should have the right title" do
            visit  '/static_pages/help'
            page.should have_selector('title',
                           :text => 'Ruby on rails Tutorial Sample App')
        end
        it "should not have custom title" do
            visit  '/static_pages/help'
            page.should_not have_selector('title',
                           :text => '| Help')
        end
    end 

    describe "AboutHelp page" do
        it "Should have content 'About Us'" do
            visit  '/static_pages/about'
            page.should have_selector('h1', :text => 'About Us')
        end
        it "should have the right title" do
            visit  '/static_pages/about'
            page.should have_selector('title',
                           :text => 'Ruby on rails Tutorial Sample App| About Us')
        end
    end 

    describe "Contact page" do
        it "Should have content 'Contact'" do
            visit  '/static_pages/contact'
            page.should have_selector('h1', :text => 'Contact')
        end
        it "should have the right title" do
            visit  '/static_pages/contact'
            page.should have_selector('title',
                           :text => 'Ruby on rails Tutorial Sample App| Contact')
        end
    end 


end
