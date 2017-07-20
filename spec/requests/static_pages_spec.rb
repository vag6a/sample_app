require 'rails_helper'
#require 'capybara/rails'
#require 'capybara/rspec'
require_relative '../support/utilities'

RSpec.describe "Static Pages", type: [:model, :request] do

    subject { page }

    describe "Home page" do

        before { visit '/'}
        it { should have_selector('h1', text: 'Sample App')}
        it { should have_selector('title', text: full_title('Home'))}
        describe "for signed-in users" do
            let(:user) { FactoryGirl.create(:user) }
            before do
                sign_in user 
                FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
                FactoryGirl.create(:micropost, user: user, content: "Doror sit amet")
                visit root_path
            end
            it "should render user's feed" do
                user.feed.each do |item|
                    page.should have_selector("li##{item.id}", text: item.content)
                end
            end
        end
    end 

    describe "Help page" do

        before { visit '/help' }
        it { should have_selector('h1', text: 'Help')}
        it { should have_selector('title', text: full_title('Help'))}
        it { should have_selector('title', text: '| Help')}
    end 

    describe "AboutHelp page" do
        before { visit '/about' }
        it { should have_selector('h1', text: 'About Us')}
        it { should have_selector('title', text: full_title('About Us'))}
    end 

    describe "Contact page" do
        before { visit '/contact' }
        it { should have_selector('h1', text: 'Contact')}
        it { should have_selector('title', text: full_title('Contact'))}
    end

#   it "should have right link on the layout" do
#       visit signin_page
#       click_link "Sign in"
#       page.should have_selector 'title', text: full_title('Sign in')
#       click_link "About"
#       page.should have_selector 'title', text: full_title('About Us')
#       click_link "Help"
#       page.should have_selector 'title', text: full_title('Help')
#       click_link "Contact"
#       page.should have_selector 'title', text: full_title('Contact')
#       click_link "Home"
#       click_link "Sign up now!"
#       page.should have_selector 'title', text: full_title('Sign up')
#   end 
end
