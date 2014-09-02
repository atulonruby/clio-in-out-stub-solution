class Team < ActiveRecord::Base
  attr_accessible :name
  has_many :teamships,:dependent => :destroy
  has_many :users, :through => :teamships
  validates :name, :presence => true, :uniqueness => true
end
