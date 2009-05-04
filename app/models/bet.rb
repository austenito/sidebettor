class Bet < ActiveRecord::Base
  has_many :bet_conditions
  has_many :bet_types
  has_many :bet_requests
  has_one :prize
  has_one :bet_status
  
  def is_pending
    for bet_request in bet_requests
      if bet_request.is_pending
        return true
      end
    end
    false
  end
end
