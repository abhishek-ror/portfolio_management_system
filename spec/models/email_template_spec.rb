require 'rails_helper'

RSpec.describe EmailTemplate, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:body) }
  end

  describe '#render_for_contact' do
    let(:organization) { Organization.create!(name: 'Acme Corp', email: 'info@acme.com') }
    let(:contact) { Contact.create!(name: 'John Doe', email: 'john@example.com', organization: organization) }
    let(:template) do
      EmailTemplate.create!(
        subject: 'Hello {Contact.name}',
        body: "Dear {Contact.name},\n\nYour email: {Contact.email}\nOrganization: {Organization.name}\nOrg Email: {Organization.email}\nBest: {Portfolio.best_performance}%\nWorst: {Portfolio.worst_performance}%"
      )
    end

    before do
      Portfolio.create!(name: 'Fund A', balance: 1000, performance: 15.5, contact: contact)
      Portfolio.create!(name: 'Fund B', balance: 2000, performance: -3.2, contact: contact)
    end

    it 'replaces contact name shortcode' do
      result = template.render_for_contact(contact)
      expect(result[:subject]).to include('John Doe')
      expect(result[:body]).to include('John Doe')
    end

    it 'replaces contact email shortcode' do
      result = template.render_for_contact(contact)
      expect(result[:body]).to include('john@example.com')
    end

    it 'replaces organization name shortcode' do
      result = template.render_for_contact(contact)
      expect(result[:body]).to include('Acme Corp')
    end

    it 'replaces organization email shortcode' do
      result = template.render_for_contact(contact)
      expect(result[:body]).to include('info@acme.com')
    end

    it 'replaces best performance shortcode' do
      result = template.render_for_contact(contact)
      expect(result[:body]).to include('15.5')
    end

    it 'replaces worst performance shortcode' do
      result = template.render_for_contact(contact)
      expect(result[:body]).to include('-3.2')
    end

    it 'returns a hash with subject and body keys' do
      result = template.render_for_contact(contact)
      expect(result).to be_a(Hash)
      expect(result.keys).to contain_exactly(:subject, :body)
    end
  end
end
