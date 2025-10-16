require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  describe 'associations' do
    it { should belong_to(:contact) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:balance) }
    it { should validate_presence_of(:performance) }
    it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:performance) }
  end
end
