class Bet < ActiveRecord::Base
  has_many :bet_conditions
  has_many :bet_requests
  has_many :bet_ratios
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
  
  def get_challenger
    request = BetRequest.find(:first, :conditions => ['user_id != ?', user_id])
    User.find(:first, :conditions => ['id = ?', request.user_id])
  end
  
  def get_bettor_ratio
    BetRatio.find(:first, :conditions => ['user_id = ? AND bet_id = ?', user_id, id]).ratio
  end
  
  def get_challenger_ratio
    BetRatio.find(:first, :conditions => ['user_id != ? AND bet_id = ?', user_id, id]).ratio
  end
end
