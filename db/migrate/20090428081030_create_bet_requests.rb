class CreateBetRequests < ActiveRecord::Migration
  def self.up
    create_table :bet_requests do |t|
      t.boolean :is_pending, :null => false      
      t.boolean :has_accepted, :null => false      
      t.references :bet, :user, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bet_requests
  end
end
