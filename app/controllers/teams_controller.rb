class TeamsController < ApplicationController
	def index
		@teams = Team.all
	end

	def create
		@team = Team.new(params[:team])
		if @team.save
			flash[:notice] = "New Team was sccucessfully created."
			redirect_to teams_path
		else
			flash[:alert] = "Something went wrong, Please try again"
			redirect_to new_team_path
		end
	end

	def new
		@team = Team.new
	end

	def destroy
		@team = Team.find(params[:id])
		@team.destroy
		flash[:notice] = "#{@team.name} team was succesfully destroyed"
		redirect_to teams_path
	end

	def edit
		@team = Team.find(params[:id])
	end

	def show
		@team = Team.find(params[:id])
	end

	def update
		@team = Team.find(params[:id])
		if @team.update_attributes(params[:team])
			flash[:notice] = "Team update was successful."
			redirect_to teams_path
		else
			flash[:alert] = "Something went wrong, Please try again"
			redirect_to new_team_path
		end
	end


	def manage_users
		@team = Team.find(params[:id])
		if params.has_key?(:add)
			user = User.find(params[:add])
			Teamship.by_user(user).map(&:destroy)
			@team.users << user
		end
		if params.has_key?(:remove)
			user = User.find(params[:remove])
			Teamship.by_user(user).map(&:destroy)
		end
	end
end
