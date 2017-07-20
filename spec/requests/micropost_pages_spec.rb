require 'rails_helper'
require './spec/support/utilities'

RSpec.describe "Micropost Pages", type: :request do

  subject{ page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid info" do
      it "should not create micropost " do
        old_count = Micropost.count
        click_button "Post"
        new_count = Micropost.count
        new_count.should == old_count
      end
      describe "error message" do
        it {
        click_button "Post"
        should have_content("error") }
      end
    end
  end

  describe "micropost destruction" do
    before {FactoryGirl.create(:micropost, user: user) }
    describe "as correct user" do
      before { visit root_path }
      it "should delete micropost" do
        old_count = Micropost.count
        click_link "delete"
        new_count = Micropost.count
        new_count.should == old_count-1
      end
    end
  end

end
