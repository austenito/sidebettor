class BetNotifier < ActionMailer::Base
  
  def request_notification(user, challenger, bet)
    recipients challenger.email
    from       "ito.austen@gmail.com"
    subject    "New Bet Request"
    body       :user => user, :challenger => challenger, :bet => bet
  end
end
