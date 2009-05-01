class DashboardsController < ApplicationController
  def new
    
  end
  
  def create
  end
  
  def show
    @user_bets = Bet.find(:all, :conditions => ['user_id = ?', current_user.id])
    @pending_requests = BetRequest.find(:all, :conditions => ['user_id = ? AND is_pending = ?', current_user.id, true])
  end
 
  def edit
  end
  
  def update
  end
end
