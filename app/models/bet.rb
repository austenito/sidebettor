class Bet < ActiveRecord::Base
  has_many :bet_conditions, :dependent => :delete_all
  has_many :bet_requests, :dependent => :delete_all
  has_one :prize, :dependent => :delete, :validate => true
  belongs_to :user
  has_and_belongs_to_many :users  
  
  validates_presence_of :title, :message => 'is required'
  validate :has_condition, :has_prize, :has_challenger

  def challenger_login
    for bet_request in bet_requests
      if !bet_request.user_id.nil? && bet_request.user_id != user.id
        return User.find(bet_request.user_id).login
      end
    end
    nil
  end
  
  def prize_name
    prize.name if prize
  end
  
  def bet_condition
    bet_conditions[0].condition if bet_conditions.length > 0
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
    errors.add('', 'Bet Condition is required') if bet_conditions.length == 0 || bet_conditions[0].condition.blank?
  end
  
  def has_prize
    errors.add('', 'Prize is required') if prize.name.blank?
  end
  
  def has_challenger
    errors.add('', 'Challenger does not exist') if bet_requests.length < 2 || bet_requests[1].user_id.nil?
  end
end
