class DashboardsController < ApplicationController
  def new
    
  end
  
  def create
  end
  
  def show
    @user_bets = Bet.find(:all, 
                          :include => [:bet_requests, :bet_status],
                          :conditions => ['bet_requests.user_id = ? AND 
                                           bet_requests.has_accepted = ? AND
                                           bet_statuses.is_pending = ? AND
                                           bet_statuses.is_completed = ?', current_user.id, true, false, false])                                                                
    @pending_bets = Bet.find(:all, 
                             :include => [:bet_requests, :bet_status],
                             :conditions => ['bets.user_id = ? AND 
                                              bet_statuses.is_pending = ? AND
                                              bet_statuses.is_completed = ?', current_user.id, true, false])            
    @requested_bets = Bet.find(:all, 
                               :include => [:bet_requests, :bet_status],
                               :conditions => ['bets.user_id != ? AND
                                                bet_requests.user_id = ? AND 
                                                bet_statuses.is_pending = ? AND
                                                bet_statuses.is_completed = ?', current_user.id, current_user.id, true, false])                         
  end
 
  def edit
  end
  
  def update
  end
end
