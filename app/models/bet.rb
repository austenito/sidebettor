class Bet < ActiveRecord::Base
  has_many :bet_conditions, :dependent => :delete_all
  has_many :bet_requests, :dependent => :delete_all
  has_one :prize, :dependent => :delete, :validate => true
  has_one :bet_status, :dependent => :delete
  belongs_to :user
  has_and_belongs_to_many :users  
  
  validates_presence_of :title, :message => 'is required'
  validate :has_condition, :has_prize, :has_challenger

  def challenger_login
    user.login if user
  end

  def challenger_login=(login)
    self.user = User.find_by_login(login) unless login.blank?
  end
  
  def prize_name
    prize.name if prize
  end
  
  def bet_condition
    bet_conditions[0].condition if bet_conditions.length > 0
  end
  
  def get_challenger
    request = BetRequest.find(:first, :conditions => ['user_id != ?', user_id])
    User.find(:first, :conditions => ['id = ?', request.user_id])
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
  
  def is_participant(user_id)
    requests = BetRequest.find(:all, :conditions => ['bet_id = ? AND user_id = ?', self.id, user_id])
    if requests.empty?
      false
    else
      true
    end
  end
  
  private 
  
  def has_condition
    errors.add('', 'Bet Condition is required') if bet_conditions.length == 0 || bet_conditions[0].condition.length == 0
  end
  
  def has_prize
    errors.add('', 'Prize is required') if prize.name.length == 0
  end
  
  def has_challenger
    errors.add('', 'Challenger does not exist') if bet_requests.length < 2 || bet_requests[1].user_id.nil?
  end
  
  def is_bettor(bet_object)
    (bet_object.user_id.equal? user_id) && (bet_object.bet_id.equal? id)    
  end
end
