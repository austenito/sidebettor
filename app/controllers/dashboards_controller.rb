class DashboardsController < ApplicationController
  def new
    
  end
  
  def create
  end
  
  def show
    @user_bets = Bet.find(:all, 
                          :include => [:bet_requests],
                          :conditions => ['bet_requests.user_id = ? AND
                                           bet_requests.has_accepted = ? AND                            
                                           bets.is_active = ? AND
                                           bets.is_closed = ?', current_user.id, true, true, false])                                                                
    @pending_bets = Bet.find(:all, 
                             :conditions => ['bets.user_id = ? AND 
                                              bets.is_active = ? AND
                                              bets.is_closed = ?', current_user.id, false, false])            
    @requested_bets = Bet.find(:all, 
                               :include => [:bet_requests],
                               :conditions => ['bets.user_id != ? AND
                                                bet_requests.user_id = ? AND 
                                                bets.is_active = ? AND
                                                bets.is_closed = ?', current_user.id, current_user.id, false, false])                         
  end
 
  def edit
  end
  
  def update
  end
end
