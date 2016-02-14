class Category < ActiveRecord::Base

  validates :name, presence: true, length: {minimum: 3}
  validates :description, presence: true, length: {minimum: 3}

  has_many :nominees
  has_many :bets, :through => :nominees
  validates_associated :nominees
end
