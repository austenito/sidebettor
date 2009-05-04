class DashboardsController < ApplicationController
  def new
    
  end
  
  def create
  end
  
  def show
    @user_bets = Bet.find(:all, 
                          :joins => [:bet_requests],
                          :conditions => ['bet_requests.user_id = ?', current_user.id],
                          :group => :bet_id)
    @pending_bets = Bet.find(:all, 
                             :conditions => ["user_id = ?", current_user.id])
    @requested_bets = Bet.find(:all,
                               :joins => [:bet_requests],
                               :conditions => ["bet_requests.user_id = ? AND is_pending = ?", current_user.id, true] )                             
  end
 
  def edit
  end
  
  def update
  end
end
