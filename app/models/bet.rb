class Bet < ActiveRecord::Base
  has_many :bet_conditions
  has_many :bet_types
  has_many :bet_requests
  has_one :prize
  has_one :bet_status
end
