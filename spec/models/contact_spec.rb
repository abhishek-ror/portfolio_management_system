require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'associations' do
    it { should belong_to(:organization) }
    it { should have_many(:portfolios).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    
    it 'validates email format' do
      contact = Contact.new(name: 'Test', email: 'invalid', organization: Organization.create!(name: 'Test Org', email: 'test@example.com'))
      expect(contact).not_to be_valid
      expect(contact.errors[:email]).to be_present
    end
  end

  describe 'methods' do
    let(:organization) { Organization.create!(name: 'Test Org', email: 'org@example.com') }
    let(:contact) { Contact.create!(name: 'John Doe', email: 'john@example.com', organization: organization) }

    describe '#best_performance' do
      it 'returns 0 when no portfolios exist' do
        expect(contact.best_performance).to eq(0)
      end

      it 'returns the highest performance value' do
        Portfolio.create!(name: 'Fund A', balance: 1000, performance: 15.0, contact: contact)
        Portfolio.create!(name: 'Fund B', balance: 2000, performance: -5.0, contact: contact)
        Portfolio.create!(name: 'Fund C', balance: 1500, performance: 8.5, contact: contact)
        
        expect(contact.best_performance).to eq(15.0)
      end
    end

    describe '#worst_performance' do
      it 'returns 0 when no portfolios exist' do
        expect(contact.worst_performance).to eq(0)
      end

      it 'returns the lowest performance value' do
        Portfolio.create!(name: 'Fund A', balance: 1000, performance: 15.0, contact: contact)
        Portfolio.create!(name: 'Fund B', balance: 2000, performance: -5.0, contact: contact)
        Portfolio.create!(name: 'Fund C', balance: 1500, performance: 8.5, contact: contact)
        
        expect(contact.worst_performance).to eq(-5.0)
      end
    end
  end
end
