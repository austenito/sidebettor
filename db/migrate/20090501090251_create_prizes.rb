class CreatePrizes < ActiveRecord::Migration
  def self.up
    create_table :prizes do |t|
      t.string :prize, :null => false
      t.references :prize_category
      t.timestamps
    end
  end

  def self.down
    drop_table :prizes
  end
end
