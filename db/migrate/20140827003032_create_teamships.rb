class CreateTeamships < ActiveRecord::Migration
  def change
    create_table :teamships do |t|
    	t.integer :team_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
