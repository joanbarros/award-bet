class Bet < ActiveRecord::Base
  validates :amount, :presence => true, :numericality => {:greater_than => 0}
  validates :nominee_id, :presence => true
  validates :user_id, :presence => true
end
