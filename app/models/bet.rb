class Bet < ActiveRecord::Base
  has_many :bet_conditions, :dependent => :delete_all
  has_many :bet_requests, :dependent => :delete_all
  has_many :bet_ratios, :dependent => :delete_all
  has_one :prize, :dependent => :delete, :validate => true
  has_one :bet_status, :dependent => :delete
  belongs_to :user
  has_and_belongs_to_many :users  
  
  validates_presence_of :title
  
  def get_challenger
    request = BetRequest.find(:first, :conditions => ['user_id != ?', user_id])
    User.find(:first, :conditions => ['id = ?', request.user_id])
  end
  
  def get_bettor_ratio
    for ratio in bet_ratios
      if is_bettor(ratio)
        return ratio
      end
    end
    BetRatio.new
  end
  
  def get_challenger_ratio
    for ratio in bet_ratios
      if !is_bettor(ratio)
        return ratio
      end
    end
    BetRatio.new
  end
  
  def get_bettor_condition
    for condition in bet_conditions
      if is_bettor(condition)
        return condition
      end
    end
    BetCondition.new    
  end
  
  def get_challenger_condition
    for condition in bet_conditions
      if !is_bettor(condition)
        return condition
      end
    end
    BetCondition.new    
  end
  
  private 
  
  def is_bettor(bet_object)
    (bet_object.user_id.equal? user_id) && (bet_object.bet_id.equal? id)    
  end
end
