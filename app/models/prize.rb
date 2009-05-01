class Prize < ActiveRecord::Base
  has_many :prize_categories
  belongs_to :bet
end
