ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => "users"
  map.register '/register', :controller => 'users', :action => 'new'  
  map.register '/login', :controller => 'user_sessions', :action => 'new'     
  
  map.resource :user_session
  map.resources :bets
  map.resource :dashboard
  map.resource :bet_request
  map.resources :bet_statuses
  map.resources :users
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
