require 'rails_helper'
require_relative '../support/utilities'

RSpec.describe "UserPages", type: :request do
   subject { page }

    describe "signup page" do
        before { visit signup_path }
        it { should have_selector('h1', text: 'Sign Up')}
        it { should have_selector('title', text: full_title('Sign up'))}
    end 

    describe "profile page" do
        let (:foobar) { FactoryGirl.create(:user)}
        before { visit user_path(foobar) }
        it { should have_selector('h1', text: foobar.name)}
        it { should have_selector('title', text: foobar.name) }
    end

    describe "signup" do
        before { visit signup_path }
        let(:submit) {"Create my account"}

        describe "with invalid info" do
            it "should not create user" do
                old_count = User.count
                click_button submit
                new_count = User.count
                new_count.should == old_count
            end
        end

        describe "after submission" do
            before { click_button submit }
            it {should have_selector('title', text: 'Sign up')}
            it {should have_content('error') }
            it {should_not have_content('Password digest') }
        end

        describe "with valid info" do
            before do
                fill_in "Name",         with: "Example User"
                fill_in "Email",        with: "vag6a@yahoo.com"
                fill_in "Password",     with: "foobar"
                fill_in "Confirmation", with: "foobar"
            end

            it "should create user" do
                old_count = User.count
                click_button submit
                new_count = User.count
                new_count.should == old_count + 1
            end

            describe "after saving user" do
                before { click_button submit }
                let(:user) { User.find_by_email("vag6a@yahoo.com")}
                it { should have_selector('title', text: user.name) }
                it { should have_selector('div.alert.alert-success', text: 'Welcome') }
            end
        end
    end 

end
