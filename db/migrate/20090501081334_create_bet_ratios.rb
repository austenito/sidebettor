class CreateBetRatios < ActiveRecord::Migration
  def self.up
    create_table :bet_ratios do |t|
      t.integer :ratio
      t.timestamps
    end
  end

  def self.down
    drop_table :bet_ratios
  end
end
