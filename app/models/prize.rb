class Prize < ActiveRecord::Base
  belongs_to :bet
  
  validates_presence_of :name
end
