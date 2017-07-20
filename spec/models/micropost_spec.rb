require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryGirl.create(:user)}
      before do
        @micropost = user.microposts.build(content:"Lorem impsem")
    end

    subject { @micropost}

    it { should respond_to(:content) }
    it { should respond_to(:user_id) }
    it { should respond_to(:user)}
    it "user must be the same" do
      subject.user.should == user 
    end

    it { should be_valid }

    # describe "accessible attributes" do
    #   it "should not allow access to user id" do
    #      expect do
    #        Micropost.new(user_id: "1")
    #      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    #    end
    # end 

    describe "when user_id is not present" do
      before { @micropost.user_id = nil }
      it { should_not be_valid }
    end

    describe "with blank content" do
      before { @micropost.content = " " }
      it { should_not be_valid }
    end

    describe "with content tat is too long" do
      before { @micropost.content = "a"*141 }
      it { should_not be_valid }
    end
end
