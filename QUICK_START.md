# Quick Start Guide

## Prerequisites
- Ruby 3.3.5 or higher
- PostgreSQL running
- Bundler installed

## Setup (3 minutes)

```bash
cd portfolio_management_system

bundle install

rails db:create
rails db:migrate
rails db:seed

rails server
```

Visit: http://localhost:3000

## Run Tests

```bash
bundle exec rspec
```

Expected: 29 examples, 0 failures

## What You'll See

### Home Page (Contacts Dashboard)
- 3 contacts listed
- Each with their portfolios
- Performance metrics
- Email template selection
- Preview and Send buttons

### Try These Actions

1. **Preview an Email**
   - Select a template from dropdown
   - Click "Preview" button
   - See modal with rendered email

2. **Send an Email**
   - Select a template
   - Click "Send" button
   - Confirm action
   - See success message

3. **Manage Templates**
   - Click "Email Templates" button
   - View all templates
   - Click "New Template"
   - Create template with shortcodes
   - Save and use it

## Available Shortcodes

Use these in email templates:
- `{Contact.name}`
- `{Contact.email}`
- `{Organization.name}`
- `{Organization.email}`
- `{Portfolio.best_performance}`
- `{Portfolio.worst_performance}`

## Sample Template

Subject:
```
Monthly Report for {Contact.name}
```

Body:
```
Hello {Contact.name},

Organization: {Organization.name}

Your portfolio performance:
Best: {Portfolio.best_performance}%
Worst: {Portfolio.worst_performance}%

Contact us at {Organization.email}
```

## Key Routes

- `/` - Contacts Dashboard
- `/email_templates` - Template Management
- `/email_templates/new` - Create Template

## Stopping the Server

Press `Ctrl+C` in the terminal

## Reset Database

```bash
rails db:seed:replant
```

This will clear and reload all seed data.

## That's It!

You now have a fully functional Portfolio Management System with:
- Contact management
- Portfolio tracking
- Dynamic email templates
- Shortcode system
- Preview and send functionality
- Comprehensive test suite

Enjoy!
