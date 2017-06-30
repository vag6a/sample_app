require 'rails_helper'

describe ApplicationHelper do
    describe "full_title" do
        it "should include page name" do
            full_title("foo").should =~ /foo/
        end
        it "should include base title" do
            full_title("foo").should =~ /^Ruby on rails Tutorial/
        end
        it "should not include bar" do
            full_title("").should_not =~ /\|/
        end
    end
end
