class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   @bet = Bet.new
  end
  
  def create        
    # Create the bet conditions
    params[:bet][:user_bet_conditions][:user_id] = current_user.id
    user_ratio = params[:bet][:user_bet_conditions][:ratio]
    params[:bet][:user_bet_conditions].delete(:ratio)
    user_condition = BetCondition.new(params[:bet][:user_bet_conditions])
    
    challenger_ratio = params[:bet][:challenger_bet_conditions][:ratio]
    params[:bet][:challenger_bet_conditions].delete(:ratio)    
    challenger_condition = BetCondition.new(params[:bet][:challenger_bet_conditions])  
    
    # Create the bet
    title = params[:bet][:title]
    end_date = Date.today
    bet = Bet.new(:title => title, :end_date => end_date, :user_id => current_user.id)
    bet.bet_conditions.push(user_condition)
    bet.bet_conditions.push(challenger_condition)
    
    # Create the bet requests
    user_request = BetRequest.new(:bet_id => bet.id, :user_id => current_user.id, :is_pending => false, :has_accepted => false)
    challenger_request = BetRequest.new(:bet_id => bet.id, :user_id => challenger_condition.user_id, :is_pending => true, :has_accepted => false)
    bet.bet_requests.push(user_request)
    bet.bet_requests.push(challenger_request)
    bet.save    

    # Create the prize and prize category
    prize_category = PrizeCategory.new(:prize_category => 'None')
    prize_category.save
    prize = Prize.new(:bet_id => bet.id, :prize_category_id => prize_category.id, :name => params[:bet][:prize])
    prize.save
    
    # Set the user's bet ratio
    user_ratio = BetRatio.new(:bet_id => bet.id, :user_id => current_user.id, :ratio => user_ratio.to_i)
    user_ratio.save
    
    # Set the challenger's bet ratio
    challenger_conditions = params[:bet][:challenger_bet_conditions]
    challenger_ratio = BetRatio.new(:bet_id => bet.id, :user_id => challenger_conditions[:user_id], :ratio => challenger_ratio.to_i)
    challenger_ratio.save
        
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
