# Setup Verification Guide

This document helps verify that the Portfolio Management System is correctly set up and working.

## Quick Start

```bash
cd portfolio_management_system
bundle install
rails db:create db:migrate db:seed
rails server
```

Visit: http://localhost:3000

## Verification Checklist

### 1. Database Setup
```bash
rails db:migrate:status
```
Expected: 4 migrations should be UP
- CreateOrganizations
- CreateContacts
- CreatePortfolios
- CreateEmailTemplates

### 2. Seed Data Verification
```bash
rails console
```

In console:
```ruby
Organization.count
Contact.count
Portfolio.count
EmailTemplate.count
```

Expected output:
- Organizations: 2
- Contacts: 3
- Portfolios: 6
- EmailTemplates: 3

### 3. Test Suite
```bash
bundle exec rspec
```

Expected output:
```
29 examples, 0 failures
```

### 4. Routes Verification
```bash
rails routes | grep -E "(contacts|email_templates)"
```

Should show:
- Root route to contacts#index
- Contacts routes
- Email templates CRUD routes
- Preview and send_email routes

### 5. Application Features to Test

#### A. Contacts Dashboard (/)
- [ ] Page loads successfully
- [ ] Shows 3 contacts (Alice, Bob, Carol)
- [ ] Each contact shows their organization
- [ ] Each contact shows their portfolios
- [ ] Best/Worst performance is displayed
- [ ] Email template dropdown is visible
- [ ] Preview button is present
- [ ] Send button is present

#### B. Email Templates (/email_templates)
- [ ] Page loads successfully
- [ ] Shows 3 templates
- [ ] "New Template" button works
- [ ] View button shows template details
- [ ] Edit button opens edit form
- [ ] Delete button removes template (with confirmation)

#### C. Template Creation
- [ ] Can access /email_templates/new
- [ ] Form shows subject field
- [ ] Form shows body textarea
- [ ] Shortcode hints are displayed
- [ ] Can save a new template
- [ ] Validates required fields

#### D. Preview Functionality
- [ ] Select a template from dropdown on contacts page
- [ ] Click Preview button
- [ ] Modal popup appears
- [ ] Shows rendered subject with contact data
- [ ] Shows rendered body with contact data
- [ ] All shortcodes are replaced

#### E. Send Functionality
- [ ] Select a template from dropdown
- [ ] Click Send button
- [ ] Confirmation dialog appears
- [ ] Flash message appears after confirmation
- [ ] Message shows email was "sent"

### 6. Shortcode Testing

Create a test template with all shortcodes:

Subject:
```
Test for {Contact.name}
```

Body:
```
Hello {Contact.name},

Your email: {Contact.email}
Organization: {Organization.name}
Organization email: {Organization.email}

Performance:
Best: {Portfolio.best_performance}%
Worst: {Portfolio.worst_performance}%
```

Preview with different contacts to verify all shortcodes work.

### 7. JavaScript Functionality
- [ ] Preview opens modal without page reload
- [ ] Modal close button works
- [ ] Clicking outside modal closes it
- [ ] Send shows confirmation dialog
- [ ] Both features work for all contacts

### 8. Styling Verification
- [ ] Clean, modern UI
- [ ] Buttons have hover effects
- [ ] Cards have proper shadows
- [ ] Table layout is clean
- [ ] Form fields are properly styled
- [ ] Modal is centered and styled

### 9. Error Handling
Try these scenarios:

- [ ] Create template without subject - should show error
- [ ] Create template without body - should show error
- [ ] Try to preview without selecting template - should show alert
- [ ] Try to send without selecting template - should show alert

### 10. Model Validations
In rails console:

```ruby
org = Organization.new(name: "Test")
org.valid?

contact = Contact.new(name: "Test")
contact.valid?

portfolio = Portfolio.new(name: "Test")
portfolio.valid?
```

All should return false with appropriate errors.

## Common Issues and Solutions

### Issue: Database doesn't exist
Solution:
```bash
rails db:create
```

### Issue: Migrations not run
Solution:
```bash
rails db:migrate
```

### Issue: No data in database
Solution:
```bash
rails db:seed
```

### Issue: Tests failing
Solution:
```bash
RAILS_ENV=test rails db:migrate
bundle exec rspec
```

### Issue: Port 3000 already in use
Solution:
```bash
rails server -p 3001
```

### Issue: JavaScript not working
- Check browser console for errors
- Ensure csrf-token meta tag is present
- Check if Turbo is interfering

## Performance Checks

### Database Query Efficiency
In development.log, check for N+1 queries.
The contacts index should use eager loading:
```
Contact.includes(:organization, :portfolios)
```

### Test Performance
Tests should complete in under 2 seconds.

## Security Checks

- [ ] CSRF protection is enabled
- [ ] Email validation works
- [ ] SQL injection prevented (using ActiveRecord)
- [ ] No sensitive data in logs

## Browser Testing

Test in:
- [ ] Chrome/Chromium
- [ ] Firefox
- [ ] Safari (if on Mac)

## Final Verification

Run all checks:
```bash
bundle exec rspec
rails db:seed:replant
rails server
```

Visit http://localhost:3000 and test all features manually.

## Success Criteria

✅ All 29 tests pass
✅ Seed data loads successfully
✅ All pages load without errors
✅ Preview shows correct data
✅ Send simulates email correctly
✅ CRUD operations work for templates
✅ Shortcodes replace correctly
✅ UI is clean and professional

If all criteria are met, the application is ready for use!
