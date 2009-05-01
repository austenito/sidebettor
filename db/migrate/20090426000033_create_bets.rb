class CreateBets < ActiveRecord::Migration
  def self.up
    create_table :bets do |t|
      t.string :title, :null => false
      t.date :end_date, :null => false
      t.references :user, :prize
      t.timestamps
    end
  end

  def self.down
    drop_table :bets
  end
end
