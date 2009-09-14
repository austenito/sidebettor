class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   
   if session[:bet].nil?
        @bet = Bet.new
        @date = Date.today
      else
        @bet = session[:bet]
        @date = @bet.end_date
      end
      session[:bet] = nil
  end
  
  def create  
    bet_array = params[:bet]    
    end_date = create_date(params[:date])
    bet = Bet.new(:title => bet_array[:title], :end_date => end_date, :user_id => current_user.id)        
    bet.build_prize(:name => bet_array[:prize_name])

    bet_condition = BetCondition.new(:condition => bet_array[:bet_condition])
    bet.bet_conditions.push(bet_condition)

    user_request = BetRequest.new(:user_id => current_user.id, :has_accepted => true)
    bet.bet_requests.push(user_request)

    challenger = User.find(:first, :conditions => ['login = ?', bet_array[:challenger_login]])      
    if challenger
      challenger_request = BetRequest.new(:user_id => challenger.id, :has_accepted => false)
      bet.bet_requests.push(challenger_request)
    end

    if bet.save
      # session[:bet] = nil
      # BetNotifier.deliver_request_notification(current_user, challenger, bet)
      redirect_to dashboard_path
    else
      session[:bet] = bet
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
  
  def create_date(date_hash)
    Date.new(date_hash[:year].to_i, m=date_hash[:month].to_i, d=date_hash[:day].to_i)
  end
     
end
