class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   @bet = Bet.new
   @prize = Prize.new
   @user_ratio = BetRatio.new
   @challenger_ratio = BetRatio.new
   @user_condition = BetCondition.new
   @challenger_condition = BetCondition.new
  end
  
  def create  
    bet_array = params[:bet]    
    @bet = Bet.new(:title => bet_array[:title], :end_date => Date.today, :user_id => current_user.id)        
    if @bet.save
      @prize = @bet.build_prize(bet_array[:prize]) 
      @bet.create_bet_status(:is_completed => false)    
    
      @user_ratio = @bet.bet_ratios.build(:user_id => current_user.id, :ratio => bet_array[:user_ratio][:ratio])
      @user_condition = @bet.bet_conditions.build(:user_id => current_user.id, :condition => bet_array[:user_condition][:condition])
      @bet.bet_requests.build(:user_id => current_user.id, :is_pending => false, :has_accepted => false)
    
      challenger = User.find(:first, :conditions => ['id = ?', bet_array[:user_id]])
      @challenger_ratio = @bet.bet_ratios.build(:user_id => challenger.id, :ratio => bet_array[:challenger_ratio][:ratio])
      @challenger_condition = @bet.bet_conditions.build(:user_id => challenger.id, :condition => bet_array[:challenger_condition][:condition])
      @bet.bet_requests.build(:user_id => challenger.id, :is_pending => true, :has_accepted => false)          
    
      if @bet.save
        redirect_to dashboard_path
      else
        @bet.delete
        @users = User.find(:all, :conditions => ['id != ?', current_user.id])
        render :template => 'bets/new.html.erb'      
      end
    end
  end
  
  def show
    
  end
 
  def edit
   
  end
  
  def update
       
  end
end
