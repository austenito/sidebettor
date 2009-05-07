class BetsController < ApplicationController
  def new
   @users = User.find(:all, :conditions => ['id != ?', current_user.id])
   @bet= Bet.new
  end
  
  def create  
    @bet = create_bet(params)      
    # Create the bet conditions
    @user_ratio = get_ratio_and_remove(params, :user_bet_conditions) 
    # user_condition = create_user_bet_condition(params)
    # params[:bet][:user_bet_conditions][:user_id] = current_user.id
    # user_condition = BetCondition.new(params[:bet][:user_bet_conditions])
    @user_condition = create_bet_condition(params, :user_bet_conditions)
    @bet.bet_conditions.push(@user_condition)
    # challenger_ratio = params[:bet][:challenger_bet_conditions][:ratio]
    # params[:bet][:challenger_bet_conditions].delete(:ratio)    
    # challenger_condition = BetCondition.new(params[:bet][:challenger_bet_conditions])  
    @challenger_ratio = get_ratio_and_remove(params, :challenger_bet_conditions) 
    @challenger_condition = create_bet_condition(params, :challenger_bet_conditions)
    @bet.bet_conditions.push(@challenger_condition)
    # Create the bet
    # title = params[:bet][:title]
    # end_date = Date.today
    # bet = @bet.new(:title => title, :end_date => end_date, :user_id => current_user.id)
    
    # Create the bet requests
    user_request = BetRequest.new(:bet_id => @bet.id, :user_id => current_user.id, :is_pending => false, :has_accepted => false)
    challenger_request = BetRequest.new(:bet_id => @bet.id, :user_id => @challenger_condition.user_id, :is_pending => true, :has_accepted => false)
    @bet.bet_requests.push(user_request)
    @bet.bet_requests.push(challenger_request)
    
    if @bet.save 
      @prize = Prize.new(:bet_id => @bet.id, :name => params[:bet][:prize])            
      @user_ratio = BetRatio.new(:bet_id => @bet.id, :user_id => current_user.id, :ratio => @user_ratio.to_i)
      @challenger_ratio = BetRatio.new(:bet_id => @bet.id, :user_id => @challenger_condition.user_id, :ratio => @challenger_ratio.to_i)
      bet_status = BetStatus.new(:is_completed => false, :bet_id => @bet.id)    
      
      if @prize.save && @user_ratio.save && @challenger_ratio.save && bet_status.save
        redirect_to dashboard_path      
      else
        @bet.delete
        render_invalid_bet
      end
    else
      # @bet.delete
      # @users = User.find(:all, :conditions => ['id != ?', current_user.id])
      # render :template => 'bets/new.html.erb'
      @bet.delete
      render_invalid_bet
    end
  end
  
  def show
    
  end
 
  def edit
   
  end
  
  def update
       
  end

  private
  
  def clean_records(records)
    for record in records
      record.delete
    end
  end
  
  def render_invalid_bet
    @users = User.find(:all, :conditions => ['id != ?', current_user.id])
    render :action => 'new'
  end
  
  def get_ratio_and_remove(params, symbol)
    user_ratio = params[:bet][symbol][:ratio]
    params[:bet][symbol].delete(:ratio)
    user_ratio
  end
  
  def create_bet_condition(params, symbol)
    if params[:bet][symbol][:user_id] == nil
      params[:bet][symbol][:user_id] = current_user.id
    end
    BetCondition.new(params[:bet][symbol])    
  end
  
  def create_bet(params)
    title = params[:bet][:title]
    Bet.new(:title => title, :end_date => Date.today, :user_id => current_user.id)    
  end
end
