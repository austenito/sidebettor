class CreateBetRequests < ActiveRecord::Migration
  def self.up
    create_table :bet_requests do |t|
      t.boolean :has_accepted, :null => false      
      t.integer :bet_id, :null => false
      t.integer :user_id, :null => false      
      t.timestamps
    end
  end

  def self.down
    drop_table :bet_requests
  end
end
