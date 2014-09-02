require 'spec_helper'

describe TeamsController do

	let(:user) { create(:user) }

  before do
    sign_in user
    @team = Team.create(:name => "test")
  end

  describe "GET index" do
    it "renders the index template" do
    	get :index 
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "renders the index template" do
    	get :new 
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    it "renders the edit template" do	
    	get :edit, :id => @team.id
      expect(response).to render_template("edit")
    end
  end
 	
 	describe "DELETE destroy" do
    it "renders the  index template" do	
    	delete :destroy, :id => @team.id
      response.should redirect_to(teams_path)
    end

    it "sets a flash[:alert] message" do
   		delete :destroy, :id => @team.id
    	flash[:notice].should eq("#{@team.name} team was succesfully destroyed")
    end
  end

  describe "GET show" do
    it "renders the show template" do	
    	get :show, :id => @team.id
      expect(response).to render_template("show")
    end
  end

  describe "post create" do
  	before do
  		@team = Team.new(:name => "kuch bhi")
  	end

    context "on successful save" do
    	it "should render team_path" do
    		post :create, :team => {"name" => "kuch bhi"}
    		response.should redirect_to(@team)
    	end

    	it "should add a team" do
    		lambda {
        post :create, :team => {:name => @team.name}
      }.should change{Team.count}.by(1)
    	end

    	it "sets a flash[:notice] message" do
    		post :create, :team => {"name" => "kuch bhi"}
    		flash[:notice].should eq("New Team was sccucessfully created.")
    	end
    end

    context "when team is not saved" do
    	it "should render team_path" do
    		post :create
    		response.should redirect_to(new_team_path)
    	end

    	it "should not add a team" do
    		lambda {
        post :create
      }.should change{Team.count}.by(0)
    	end

    	it "sets a flash[:alert] message" do
    		post :create
    		flash[:alert].should eq("Something went wrong, Please try again")
    	end
    end

  end

  describe "post update" do
  	before do
  		@team = Team.create(:name => "test team")
  	end

    context "when team update is succesful" do
    	it "should render team_path" do
    		put :update, :team => {"name" => "test team2"}, :id => @team.id
    		response.should redirect_to(teams_path)
    	end

    	it "should update the team's name" do
    		put :update, :team => {"name" => "test team2"}, :id => @team.id
    		@team.reload
    		@team.name.should == "test team2"
    	end

    	it "sets a flash[:notice] message" do
    		put :update, :team => {"name" => "test team2"}, :id => @team.id
    		flash[:notice].should eq("Team update was successful.")
    	end
    end

    context "when team is not updated" do
    	it "should render team_path" do
    		put :update, :team => {"name" => ""}, :id => @team.id
    		response.should redirect_to(new_team_path)
    	end

    	it "sets a flash[:alert] message" do
    		put :update, :team => {"name" => ""}, :id => @team.id
    		flash[:alert].should eq("Something went wrong, Please try again")
    	end
    end
  end


 	describe "#manage users" do
 		before do
  		@team = Team.create(:name => "team1")
  		@team2 = Team.create(:name => "team2")
  		@user = User.create(:email => "jaja@ja.com", :password => "12345678",:first_name =>"left",:last_name =>"last")
  		@user2 = User.create(:email => "jaja2@ja.com", :password => "12345678",:first_name =>"right",:last_name =>"last")
  		@team.users << @user
  		@team.users << @user2
  	end

 		it "should be succesful" do
 			xhr :get, :manage_users, :id => @team.id
 			response.should be_success
 		end

 		describe "When user is added" do
 			it "should remove  that user from any team" do
 				xhr :get, :manage_users, :id => @team2.id, :add => @user2.id
 				@team.reload
 				@team.users.should_not include(@user2)
 			end

 			it "should add user to team2" do
 				xhr :get, :manage_users, :id => @team2.id, :add => @user2.id
 				@team2.users.should include(@user2)
 			end
 		end

 		describe "when user is is removed" do
 			it "should remove  that user from that team" do
 				xhr :get, :manage_users, :id => @team.id, :remove => @user.id
 				@team.reload
 				@team.users.should_not include(@user)
 			end
 		end

 	end
end
