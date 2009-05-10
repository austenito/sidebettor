class BetRatio < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet
  
  validates_numericality_of :ratio  
end
