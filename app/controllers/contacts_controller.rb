class ContactsController < ApplicationController
  def index
    @contacts = Contact.includes(:organization, :portfolios).all
    @email_templates = EmailTemplate.all
  end
end
