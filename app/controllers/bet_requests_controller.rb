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
    request = BetRequest.find(:first, :conditions => ['id = ?', params[:request_id]])
    request.has_accepted = params[:has_accepted]
    request.is_pending = false
    request.save
    redirect_to dashboard_path
  end
end
