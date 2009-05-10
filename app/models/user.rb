class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :bets, :dependent => :delete_all
  has_many :bet_ratios, :dependent => :delete_all
  has_many :bet_requests, :dependent => :delete_all
end
