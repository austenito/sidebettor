class CreateBets < ActiveRecord::Migration
  def self.up
    create_table :bets do |t|
      t.string :title, :null => false
      t.date :end_date, :null => false
      t.integer :user_id, :null => false
      t.integer :winner_id
      t.boolean :is_active, :null => false, :default => false
      t.boolean :is_closed, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bets
  end
end
