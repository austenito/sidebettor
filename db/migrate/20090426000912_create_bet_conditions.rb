class CreateBetConditions < ActiveRecord::Migration
  def self.up
    create_table :bet_conditions do |t|
      t.string     :condition, :null => false
      t.integer :user_id, :null => false
      t.integer :bet_id, :null => false
      t.integer :bet_type_id, :null => false
      t.integer :bet_ratio_id, :null => false                  
      t.timestamps
    end
  end

  def self.down
    drop_table :bet_conditions
  end
end
