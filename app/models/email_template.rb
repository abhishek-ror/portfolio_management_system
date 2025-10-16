class EmailTemplate < ApplicationRecord
  validates :subject, presence: true
  validates :body, presence: true
  
  def render_for_contact(contact)
    rendered_subject = subject.dup
    rendered_body = body.dup
    
    rendered_subject.gsub!('{Contact.name}', contact.name)
    rendered_subject.gsub!('{Contact.email}', contact.email)
    rendered_subject.gsub!('{Organization.name}', contact.organization.name)
    rendered_subject.gsub!('{Organization.email}', contact.organization.email)
    rendered_subject.gsub!('{Portfolio.best_performance}', contact.best_performance.to_s)
    rendered_subject.gsub!('{Portfolio.worst_performance}', contact.worst_performance.to_s)
    
    rendered_body.gsub!('{Contact.name}', contact.name)
    rendered_body.gsub!('{Contact.email}', contact.email)
    rendered_body.gsub!('{Organization.name}', contact.organization.name)
    rendered_body.gsub!('{Organization.email}', contact.organization.email)
    rendered_body.gsub!('{Portfolio.best_performance}', contact.best_performance.to_s)
    rendered_body.gsub!('{Portfolio.worst_performance}', contact.worst_performance.to_s)
    
    { subject: rendered_subject, body: rendered_body }
  end
end
