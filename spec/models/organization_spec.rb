require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'associations' do
    it { should have_many(:contacts).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }

    it 'validates email format' do
      organization = Organization.new(name: 'Test', email: 'invalid')
      expect(organization).not_to be_valid
      expect(organization.errors[:email]).to be_present
    end

    it 'accepts valid email' do
      organization = Organization.new(name: 'Test', email: 'test@example.com')
      expect(organization).to be_valid
    end
  end
end
