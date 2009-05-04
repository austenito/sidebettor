class CreateBetStatuses < ActiveRecord::Migration
  def self.up
    create_table :bet_statuses do |t|
      t.boolean :is_completed, :null => false
      t.integer :bet_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bet_statuses
  end
end
