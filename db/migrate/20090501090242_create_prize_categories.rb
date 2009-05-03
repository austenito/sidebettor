class CreatePrizeCategories < ActiveRecord::Migration
  def self.up
    create_table :prize_categories do |t|
      t.string :prize_category, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :prize_categories
  end
end
