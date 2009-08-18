class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   
   if session[:bet].nil?
     @bet = Bet.new
     @prize = Prize.new
     @bet_condition = BetCondition.new
   else
     @bet = session[:bet]
     @prize = session[:prize]
     # @user_condition = session[:user_condition]
     # @challenger_condition = session[:challenger_condition]
   end
   session[:bet] = nil
  end
  
  def create  
    bet_array = params[:bet]    
    bet = Bet.new(:title => bet_array[:title], :end_date => Date.today, :user_id => current_user.id)        
          
    if bet.save
      prize = bet.build_prize(bet_array[:prize]) 
      # bet.create_bet_status(:is_completed => false, :is_pending => true)    

      bet_condition = bet.bet_conditions.build(:condition => bet_array[:bet_condition][:condition])
      bet.bet_requests.build(:user_id => current_user.id, :has_accepted => true)
    
      challenger = User.find(:first, :conditions => ['id = ?', bet_array[:user_id]])
      bet.bet_requests.build(:user_id => challenger.id, :has_accepted => false)          
    
      # set_session_fields(bet, prize, user_ratio, user_condition, challenger_ratio, challenger_condition)
      if bet.save
        session[:bet] = nil
        # BetNotifier.deliver_request_notification(current_user, challenger, bet)
        redirect_to dashboard_path
      else
        bet.delete
        redirect_to :action => 'new'
      end
    else
      redirect_to :action => 'new'
    end
  end
  
  def show
    @bet = Bet.find(params[:id])
  end
 
  def edit
   
  end
  
  def update
    bet = Bet.find(params[:id])
    if !bet.nil?
      bet.is_active = false
      bet.is_closed = true
    end
    redirect_to dashboard_path
  end
  
  def destroy
    bet = Bet.find(params[:id])
    if !bet.nil?
      bet.destroy
    end
    redirect_to dashboard_path
  end
  
  private 
  
  def set_session_fields(bet, prize, user_ratio, user_condition, challenger_ratio, challenger_condition)
    session[:bet] = bet
    session[:prize] = prize
    # session[:user_condition] = user_condition
    # session[:challenger_condition] = challenger_condition 
  end
end
