class BetStatusesController < ApplicationController
  def update
    bet_status = BetStatus.find(:all, :conditions => ['id = ?', params[:bet_status_id]])
    bet_status.is_completed = params[:is_completed]
    bet_status.save
    redirect_to(dashboard_path)
  end
end
