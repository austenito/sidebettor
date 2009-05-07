class BetCondition < ActiveRecord::Base
  belongs_to :bet
  has_one :bet_ratio, :dependent => :destroy
  
  validates_presence_of :condition
end
