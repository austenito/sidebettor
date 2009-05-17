class BetStatusesController < ApplicationController
  def show
    @bet_status = BetStatus.find(params[:id])
    @bet = Bet.find(@bet_status.bet_id)
    @users = Array.new
    @users.push(User.find(@bet.user.id))
    @users.push(User.find(:first, @bet.get_challenger.id))
  end
  
  def update
    if !params[:id].nil?
      bet_status = BetStatus.find(params[:id])
      bet_status.update_attributes(:is_completed => true, :winner_id => params[:bet_status][:winner_id])
    end
    redirect_to(dashboard_path)
  end
end
