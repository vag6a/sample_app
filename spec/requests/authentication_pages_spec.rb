require 'rails_helper'
require_relative '../support/utilities'

RSpec.describe "AuthenticationPages", type: :request do
  subject { page }
  describe "signin page" do
      before { visit signin_path }
      it {should have_selector('h1',    text: 'Sign in') }
      it {should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
      before { visit signin_path }
      describe "with invalid info" do
          before { click_button "Sign in" }
          it {should have_selector('title', text: "Sign in") }
          it {should have_selector('div.alert.alert-error', text:'Invalid') }
      end
    describe "after vititing another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
    end

    describe "with valid info" do
        let(:user) { FactoryGirl.create(:user) }
        before {sign_in user }

        it {should have_selector('title',   text: user.name) }
        it {should have_link('Profile',     href: user_path(user)) }
        it {should have_link('Sign out',    href: signout_path) }
        it {should have_link('Settings',    href: edit_user_path(user)) }
        it {should have_link('Users',       href: users_path) }
        it {should_not have_link('Sign in', href: signin_path) }

        describe "followed signout" do
            before { click_link "Sign out" }
            it {should have_link('Sign in') }
        end
    end
  end

  describe "autorization" do
      describe "for non-signed user" do
        let(:user) { FactoryGirl.create(:user) }

          describe "when attempt to visit protected page" do
            before do
                visit edit_user_path(user)
                fill_in "Email",  with: user.email
                fill_in "Password", with: user.password
                click_button "Sign in"
            end
            describe "after signing in" do
                it "should render desired protected page" do
                    page .should have_selector('title', text: 'Edit user')
                end
            end
            describe "when signing in again" do
                before do
                    click_link "Sign out"
                    click_link "Sign in"
                    fill_in "Email",  with: user.email
                    fill_in "Password", with: user.password
                    click_button "Sign in"
                end
                it "should render default (profile0 page" do
                    page.should have_selector('title', text: user.name)
                end
            end
          end

        describe "In the Users controller" do
            describe "visiting edit page" do
                before { visit edit_user_path(user) }
                it { should have_selector('title', 'Sign in') }
                it { should have_selector('div.alert.alert-notice') }
            end
            describe "submitting to the update action" do
                before { put user_path(user) }
                specify { response.should redirect_to(signin_path) }
            end
            describe "visiting user index" do
                before { visit users_path }
                it { should have_selector('title', text: 'Sign in') }
            end
        end
      end

      describe "as wrong user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before { sign_in user }
        describe "Visiting Users#edit page" do
            before { visit edit_user_path(wrong_user) }
            it { should_not have_selector('title', text: "Edit user") }
        end
        describe "submitting PUT request to Users#edit" do
              before { put user_path(wrong_user) }
              specify { response.should redirect_to(root_path) }
        end
      end

      describe "as non-admin user" do
          let(:user) {FactoryGirl.create(:user) }
          let(:non_admin) {FactoryGirl.create(:user) }
          before { sign_in non_admin }
          describe "submittine DELETE request to User#destroy action" do
          before { delete user_path(user) }
          specify { response.should redirect_to(root_path) }
          end
      end
  end
end
