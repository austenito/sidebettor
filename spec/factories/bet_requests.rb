Factory.define :user_request , :class => BetRequest do |u|
  u.has_accepted false      
  u.bet_id 1
  u.user_id 1      
end

Factory.define :challenger_request , :class => BetRequest do |u|
  u.has_accepted false      
  u.bet_id 1
  u.user_id 2      
end
