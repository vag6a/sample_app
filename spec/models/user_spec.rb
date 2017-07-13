require 'rails_helper'

RSpec.describe User, type: :model do

    before do
        @user = User.new(name:"Example User", email:"user@example.com",
                             password: "foobar", password_confirmation:"foobar")
    end

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:admin) }
    it { should respond_to(:authenticate) }

    it {should be_valid }
    it { should_not be_admin }

    describe "when user name is not present" do
        before { @user.name = " " }
        it { should_not be_valid }
    end

    describe "when email is not present" do
        before { @user.email = " " }
        it { should_not be_valid }
    end

    describe "when name is too long" do
        before { @user.name = "a"*51 }
        it { should_not be_valid }
    end

    describe "when e-mail format is invalid" do
        it "shoud be invalid" do
            addresses = %w[user@foo,com THE_USER_foo.bar.org first_last@foo. foo@a+b.com foo@a_b.org]
            addresses.each do |a|
                @user.email = a
                @user.should_not be_valid
            end
        end
    end

    describe "when e-mail format is valid" do
        it "shoud be valid" do
            addresses = %w[user@foo.COM THE_USER@foo.bar.org first_last@foo.org a+b@baz.cn  a-b@baz.au ]
            addresses.each do |b|
                @user.email = b
                @user.should be_valid
            end
        end
    end

    describe "when email is taken" do
        before do
            user_the_same_email = @user.dup
            user_the_same_email.email = @user.email.upcase
            user_the_same_email.save
        end
        it { should_not be_valid }
    end

    describe "when password is not present" do
        before { @user.password = @user.password_confirmation = " "}
        it { should_not be_valid }
    end

    describe "when password doesn't match confirmationis not present" do
        before { @user.password_confirmation = "mismatch"}
        it { should_not be_valid }
    end

    describe "when password confirmation is nil" do
        before { @user.password_confirmation = nil }
        it { should_not be_valid }
    end

    describe "when password too short" do
        before { @user.password = @user.password_confirmation = "a"*5}
        it { should_not be_valid }
    end

    describe "return value of authenticate" do
        before { @user.save }
        let(:found_user) { User.find_by_email(@user.email) }
        describe "with valid password" do
            it { should == found_user.authenticate(@user.password) }
        end
        describe "with invalid password" do
            let(:user_for_invalid_pass) { found_user.authenticate("invalid") }
            it { should_not == user_for_invalid_pass }
            specify { user_for_invalid_pass.should be false }
        end
    end

    describe "remember token" do
        before { @user.save }
        it "should have remember token not blank" do
            subject.remember_token.should_not be_blank
        end
    end

end
