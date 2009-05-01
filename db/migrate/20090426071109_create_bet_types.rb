class CreateBetTypes < ActiveRecord::Migration
  def self.up
    create_table :bet_types do |t|
      t.string :bet_type, :null => false      
      t.timestamps
    end
  end

  def self.down
    drop_table :bet_types
  end
end
