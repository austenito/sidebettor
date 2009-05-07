class Bet < ActiveRecord::Base
  has_many :bet_conditions, :dependent => :delete_all
  has_many :bet_requests, :dependent => :delete_all
  has_many :bet_ratios, :dependent => :delete_all
  has_one :prize, :dependent => :delete
  has_one :bet_status, :dependent => :delete
  
  validates_presence_of :title
  
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
