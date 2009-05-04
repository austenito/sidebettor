class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   @bet_types = BetType.find(:all)
   @bet = Bet.new
  end
  
  def create        
    # Set the user's id
    user_conditions = params[:bet][:user_bet_conditions]
    user_conditions[:user_id] = current_user.id
    
    # Set the user's bet ratio
    user_ratio = BetRatio.new(:ratio => user_conditions[:ratio].to_i)
    user_ratio.save
    user_conditions[:bet_ratio_id] = user_ratio.id
    user_conditions.delete(:ratio) 
    
    # Set the challenger's bet ratio
    challenger_conditions = params[:bet][:challenger_bet_conditions]
    challenger_ratio = BetRatio.new(:ratio => challenger_conditions[:ratio].to_i)
    challenger_ratio.save
    challenger_conditions[:bet_ratio_id] = challenger_ratio.id
    challenger_conditions.delete(:ratio) 
    
    # Create the bet conditions
    user_condition = BetCondition.new(user_conditions)
    challenger_condition = BetCondition.new(challenger_conditions)  
    
    # Create the prize and prize category
    prize_category = PrizeCategory.new(:prize_category => 'None')
    prize_category.save
    prize = Prize.new(:prize_category_id => prize_category.id, :prize => params[:bet][:prize])
    prize.save
    
    # Create the bet
    title = params[:bet][:title]
    end_date = Date.today
    bet = Bet.new(:title => title, :end_date => end_date, :user_id => current_user.id, :prize_id => prize.id)
    bet.bet_conditions.push(user_condition)
    bet.bet_conditions.push(challenger_condition)
    
    # Create the bet requests
    user_request = BetRequest.new(:bet_id => bet.id, :user_id => current_user.id, :is_pending => false, :has_accepted => false)
    challenger_request = BetRequest.new(:bet_id => bet.id, :user_id => challenger_conditions[:user_id], :is_pending => true, :has_accepted => false)
    bet.bet_requests.push(user_request)
    bet.bet_requests.push(challenger_request)

    bet.save    
    
    # Create the bet status
    bet_status = BetStatus.new(:is_completed => false, :bet_id => bet.id)    
    bet_status.save
    
    redirect_to dashboard_path
  end
  
  def show
    
  end
 
  def edit
   
  end
  
  def update
       
  end

end
