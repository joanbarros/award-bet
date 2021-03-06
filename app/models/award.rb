class Award < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3}
  validates :description, presence: true, length: {minimum: 3}
  validates :closing_date, presence: true

  has_many :categories
  has_many :nominees, :through => :categories
  has_many :bets, :through => :nominees
  validates_associated :categories
end
