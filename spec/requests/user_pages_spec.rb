require 'rails_helper'
require_relative '../support/utilities'

RSpec.describe "UserPages", type: :request do
   subject { page }
       describe "signup page" do

        before { visit '/signup' }
        it { should have_selector('h1', text: 'Sign Up')}
        it { should have_selector('title', text: full_title('Sign up'))}
    end 

end
