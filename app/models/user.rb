class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :bets
  has_many :bet_ratios
end
