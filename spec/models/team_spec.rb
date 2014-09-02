require 'spec_helper'

describe Team do
    context "should not create team with no name" do
      team = Team.new(:name => "")
      specify { team.should_not be_valid }
    end
    
    context "should not create team with duplicate name" do
       team = Team.new(:name => "beta")
       team.save
       team2 = Team.new(:name => "beta")
       specify { team2.should_not be_valid }
    end
end
