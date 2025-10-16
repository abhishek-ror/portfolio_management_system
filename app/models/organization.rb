class Organization < ApplicationRecord
  has_many :contacts, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
