class Teamship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :team
  belongs_to :user

  scope :by_user, lambda{ |user| where(:user_id => user)}
end
