class BetCondition < ActiveRecord::Base
  belongs_to :bet
  has_one :bet_ratio
end
