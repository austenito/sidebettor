class CreateBetsUsers < ActiveRecord::Migration
  def self.up
    create_table :bets_users do |t|
      t.integer :bet_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bets_users
  end
end
