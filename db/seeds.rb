puts "Clearing existing data..."
EmailTemplate.destroy_all
Portfolio.destroy_all
Contact.destroy_all
Organization.destroy_all

puts "Creating organizations..."
acme = Organization.create!(
  name: "Acme Corp",
  email: "info@acmecorp.com"
)

globex = Organization.create!(
  name: "Globex Inc",
  email: "contact@globexinc.com"
)

puts "Creating contacts..."
alice = Contact.create!(
  name: "Alice Johnson",
  email: "alice@example.com",
  organization: acme
)

bob = Contact.create!(
  name: "Bob Smith",
  email: "bob@example.com",
  organization: globex
)

carol = Contact.create!(
  name: "Carol White",
  email: "carol@example.com",
  organization: acme
)

puts "Creating portfolios..."
Portfolio.create!(
  name: "Growth Fund",
  balance: 10000,
  performance: 15.0,
  contact: alice
)

Portfolio.create!(
  name: "Income Fund",
  balance: 5000,
  performance: -2.0,
  contact: alice
)

Portfolio.create!(
  name: "Equity Fund",
  balance: 20000,
  performance: 8.0,
  contact: bob
)

Portfolio.create!(
  name: "Bonds Fund",
  balance: 7500,
  performance: 3.0,
  contact: bob
)

Portfolio.create!(
  name: "Tech Portfolio",
  balance: 15000,
  performance: 22.5,
  contact: carol
)

Portfolio.create!(
  name: "Real Estate Fund",
  balance: 12000,
  performance: 5.5,
  contact: carol
)

puts "Creating email templates..."
EmailTemplate.create!(
  subject: "Monthly Portfolio Digest",
  body: "Hello {Contact.name},\n\nWe hope this email finds you well.\n\nYour organization: {Organization.name}\nOrganization email: {Organization.email}\n\nPortfolio Performance Summary:\n- Best performing portfolio: {Portfolio.best_performance}%\n- Worst performing portfolio: {Portfolio.worst_performance}%\n\nThank you for your continued trust in our services.\n\nBest regards,\nPortfolio Management Team"
)

EmailTemplate.create!(
  subject: "Welcome to Portfolio Management System",
  body: "Dear {Contact.name},\n\nWelcome to our Portfolio Management System!\n\nYour contact email: {Contact.email}\nYour organization: {Organization.name}\n\nWe're excited to have you on board. You can track your portfolio performance through our dashboard.\n\nCurrent Performance Overview:\nBest: {Portfolio.best_performance}%\nWorst: {Portfolio.worst_performance}%\n\nIf you have any questions, please don't hesitate to reach out.\n\nWarm regards,\nThe PMS Team"
)

EmailTemplate.create!(
  subject: "Quarterly Performance Report for {Contact.name}",
  body: "Hi {Contact.name},\n\nThis is your quarterly performance report.\n\nCompany: {Organization.name}\nCompany Contact: {Organization.email}\n\nYour Performance Metrics:\n• Top Performance: {Portfolio.best_performance}%\n• Bottom Performance: {Portfolio.worst_performance}%\n\nWe recommend reviewing your portfolio allocation based on these results.\n\nBest,\nInvestment Advisory Team"
)

puts "Seed data created successfully!"
puts "Organizations: #{Organization.count}"
puts "Contacts: #{Contact.count}"
puts "Portfolios: #{Portfolio.count}"
puts "Email Templates: #{EmailTemplate.count}"
