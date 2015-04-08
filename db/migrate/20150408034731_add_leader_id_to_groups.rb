class AddLeaderIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :leader_id, :integer
    change_column :groups, :leader_id, :integer, null: false, default: 0
    add_index :groups, :leader_id
  end
end
