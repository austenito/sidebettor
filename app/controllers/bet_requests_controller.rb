class BetRequestsController < ApplicationController
  def new
  end
  
  def create    
  end
  
  def show
  end
 
  def edit
  end
  
  def update
    has_accepted = params[:has_accepted]
    if has_accepted.nil?
      has_accepted = false
    end
    
    requests = BetRequest.find(:all, :conditions => ['bet_id = ?', params[:bet_id]])
    for request in requests
      request.update_attribute(:has_accepted, has_accepted)
    end
    
    bet = Bet.find(params[:bet_id])    
    if has_accepted
      bet.is_active = true
      bet.is_closed = false
    else
      bet.is_active = false
      bet.is_closed = true
    end    
    bet.save
    
    redirect_to dashboard_path
  end
end
