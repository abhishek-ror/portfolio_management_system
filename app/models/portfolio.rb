class Portfolio < ApplicationRecord
  belongs_to :contact
  
  validates :name, presence: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :performance, presence: true, numericality: true
end
