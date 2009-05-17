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
    request = BetRequest.find(:first, :conditions => ['bet_id = ? AND user_id = ?', params[:bet_id], current_user.id])
    request.update_attribute(:has_accepted, params[:has_accepted])
    
    status = BetStatus.find(:first, :conditions => ['bet_id = ?', params[:bet_id]])
    status.update_attribute(:is_pending, false)
    redirect_to dashboard_path
  end
end
