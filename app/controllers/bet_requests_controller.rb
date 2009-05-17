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
    
    status = BetStatus.find(:first, :conditions => ['bet_id = ?', params[:bet_id]])
    status.update_attribute(:is_pending, false)
    redirect_to dashboard_path
  end
end
