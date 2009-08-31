class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   
   if session[:bet].nil?
     @bet = Bet.new
     @prize = Prize.new
     @bet_condition = BetCondition.new
   else
     @bet = session[:bet]
     @prize_name = session[:prize_name]
     @challenger = session[:challenger]
     # @user_condition = session[:user_condition]
     # @challenger_condition = session[:challenger_condition]
   end
   session[:bet] = nil
  end
  
  def create  
    bet_array = params[:bet]    
    bet = Bet.new(:title => bet_array[:title], :end_date => Date.today, :user_id => current_user.id)        
    bet.build_prize(:name => bet_array[:prize_name])

    bet_condition = BetCondition.new(:condition => bet_array[:bet_condition])
    bet.bet_conditions.push(bet_condition)

    user_request = BetRequest.new(:user_id => current_user.id, :has_accepted => true)
    bet.bet_requests.push(user_request)

    challenger = User.find(:first, :conditions => ['login = ?', bet_array[:challenger_login]])    
      
    challenger_request = BetRequest.new(:user_id => challenger, :has_accepted => false)
    bet.bet_requests.push(challenger_request)

    if bet.save
      session[:bet] = nil
      # BetNotifier.deliver_request_notification(current_user, challenger, bet)
      redirect_to dashboard_path
    else
      # bet.delete
      session[:bet] = bet
      session[:prize_name] = bet.prize_name
      
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
end
