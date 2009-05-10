class Prize < ActiveRecord::Base
  belongs_to :bet
  
  validates_length_of :name, :minimum => 1, :message => 'of the prize bet is too short (minimum is {{count}} characters)'
end
