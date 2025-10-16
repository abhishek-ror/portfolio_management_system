class Contact < ApplicationRecord
  belongs_to :organization
  has_many :portfolios, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def best_performance
    portfolios.maximum(:performance) || 0
  end

  def worst_performance
    portfolios.minimum(:performance) || 0
  end
end
