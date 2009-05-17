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
      @bet.create_bet_status(:is_completed => false, :is_pending => true)    
    
      @user_ratio = @bet.bet_ratios.build(:user_id => current_user.id, :ratio => bet_array[:user_ratio][:ratio])
      @user_condition = @bet.bet_conditions.build(:user_id => current_user.id, :condition => bet_array[:user_condition][:condition])
      @bet.bet_requests.build(:user_id => current_user.id, :has_accepted => true)
    
      challenger = User.find(:first, :conditions => ['id = ?', bet_array[:user_id]])
      @challenger_ratio = @bet.bet_ratios.build(:user_id => challenger.id, :ratio => bet_array[:challenger_ratio][:ratio])
      @challenger_condition = @bet.bet_conditions.build(:user_id => challenger.id, :condition => bet_array[:challenger_condition][:condition])
      @bet.bet_requests.build(:user_id => challenger.id, :has_accepted => false)          
    
      if @bet.save
        redirect_to dashboard_path
      end
    else
      @bet.delete
      @users = User.find(:all, :conditions => ['id != ?', current_user.id])
      render :template => 'bets/new.html.erb'
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
end
