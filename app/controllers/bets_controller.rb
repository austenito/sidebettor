class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   
   if session[:bet].nil?
     @bet = Bet.new
     @prize = Prize.new
     @user_ratio = BetRatio.new
     @challenger_ratio = BetRatio.new
     @user_condition = BetCondition.new
     @challenger_condition = BetCondition.new     
   else
     @bet = session[:bet]
     @prize = session[:prize]
     @user_ratio = session[:user_ratio]
     @challenger_ratio = session[:challenger_ratio]
     @user_condition = session[:user_condition]
     @challenger_condition = session[:challenger_condition]
   end
   session[:bet] = nil
  end
  
  def create  
    bet_array = params[:bet]    
    bet = Bet.new(:title => bet_array[:title], :end_date => Date.today, :user_id => current_user.id)        
          
    if bet.save
      prize = bet.build_prize(bet_array[:prize]) 
      bet.create_bet_status(:is_completed => false, :is_pending => true)    
    
      user_ratio = bet.bet_ratios.build(:user_id => current_user.id, :ratio => bet_array[:user_ratio][:ratio])
      user_condition = bet.bet_conditions.build(:user_id => current_user.id, :condition => bet_array[:user_condition][:condition])
      bet.bet_requests.build(:user_id => current_user.id, :has_accepted => true)
    
      challenger = User.find(:first, :conditions => ['id = ?', bet_array[:user_id]])
      challenger_ratio = bet.bet_ratios.build(:user_id => challenger.id, :ratio => bet_array[:challenger_ratio][:ratio])
      challenger_condition = bet.bet_conditions.build(:user_id => challenger.id, :condition => bet_array[:challenger_condition][:condition])
      bet.bet_requests.build(:user_id => challenger.id, :has_accepted => false)          
    
      set_session_fields(bet, prize, user_ratio, user_condition, challenger_ratio, challenger_condition)
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
    session[:user_ratio] = user_ratio
    session[:user_condition] = user_condition
    session[:challenger_ratio] = challenger_ratio
    session[:challenger_condition] = challenger_condition 
  end
end
