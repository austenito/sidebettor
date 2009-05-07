class BetRatio < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet
  
  validates_presence_of :ratio  
end
