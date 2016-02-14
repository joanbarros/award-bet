class Nominee < ActiveRecord::Base


  validates :name, presence: true, length: {minimum: 3}
  validates :description, presence: true, length: {minimum: 3}


  has_many :bets 
end
