require 'rails_helper'
require_relative '../support/utilities'

RSpec.describe "UserPages", type: :request do
   subject { page }

   describe "index" do
       let(:user) { FactoryGirl.create(:user) }

        before(:all) { 30.times { FactoryGirl.create(:user) } }
        after(:all) { User.delete_all }

       before do 
           sign_in user
           visit users_path
       end
       it { should have_selector('title', text: 'All users') }
       it { should have_selector('h1', text: 'All users') }

       describe "pagination" do
        it "should list each user" do
            User.paginate(page: 1).each do |user|
                page.should have_selector('li>a', text: user.name)
            end
        end
        it {should have_selector('div.pagination') }
       end
       describe "delete links" do
           it {should_not have_link('delete') }
       end
       describe "as admin user" do
           let (:admin) { FactoryGirl.create(:admin) }
           before do
               sign_in admin
               visit users_path
           end
           it {should have_link('delete', href: user_path(User.first)) }
           it "should delete user" do
                old_count = User.count
                click_link 'delete', href: user_path(User.second)
                new_count = User.count
                new_count.should == old_count - 1
            end
       end
   end

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
                it { should have_link('Sign out') }
            end
        end
    end 

    describe "edit" do
        let(:user) {FactoryGirl.create(:user) }
        before {sign_in user 
                visit edit_user_path(user) }
        describe "page" do
            it { should have_selector('h1', text: "Update your profile") }
            it { should have_link('change', href: 'http://gravatar.com/emails') }
        end

        describe "with invalid info" do
            before { click_button "Save changes" }
            it {should have_content('error') }
        end

        describe "with valid info" do
            let(:new_name) { "New Name" }
            let(:new_email) { "new@exampe.com" }
            before do
                fill_in "Name",         with: new_name
                fill_in "Email",        with: new_email
                fill_in "Password",     with: user.password
                fill_in "Confirmation", with: user.password
                click_button "Save changes"
            end
            it { should have_selector('title', text: new_name) }
            it { should have_link('Sign out', href: signout_path) }
            it { should have_selector('div.alert.alert-success') }
            specify { user.reload.name.should  == new_name }
            specify { user.reload.email.should == new_email }
        end
    end

end
