class Category < ActiveRecord::Base
  has_many :nominees
  validates_associated :nominees
end
