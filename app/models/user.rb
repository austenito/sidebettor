class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :bets, :dependent => :delete_all
  has_many :bet_requests, :dependent => :delete_all
  has_and_belongs_to_many :bets
end
