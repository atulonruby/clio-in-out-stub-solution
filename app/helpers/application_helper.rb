module ApplicationHelper

  def name_with_status(user)
    link_to(user.full_name, user_path(user.id), :class => "name") +
    content_tag(:span, user.status, :class => "status status-#{user.status}") +
    link_to("Update", status_user_path(user.id), :class => "update-link", :remote => true) +
    link_to("Team:", teams_path,:class => "team-title") +
    user_team(user)
  end


  def user_team(user)
  	if user.team.nil?
  	 	"No team"
  	else
  		link_to "#{user.team.name.capitalize}", team_path(user.team)
  	end
  end

end
