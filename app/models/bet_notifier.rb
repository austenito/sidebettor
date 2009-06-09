class BetNotifier < ActionMailer::Base
  
  def request_notification
    recipients "austen.ito@gmail.com"
    from       "ito.austen@gmail.com"
    subject    "New account information"
    body       "Test Email"
  end
end
