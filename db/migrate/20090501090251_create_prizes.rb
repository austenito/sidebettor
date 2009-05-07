class CreatePrizes < ActiveRecord::Migration
  def self.up
    create_table :prizes do |t|
      t.string :name,  :null => false
      t.integer :bet_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :prizes
  end
end
