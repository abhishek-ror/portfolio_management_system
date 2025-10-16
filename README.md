# Portfolio Management System

A FinTech Portfolio Management System built with Ruby on Rails, featuring contact management, portfolio tracking, and dynamic email template system with shortcode support.

## Features

- **Contacts Dashboard**: View all contacts with their portfolios, organizations, and performance metrics
- **Portfolio Tracking**: Monitor multiple portfolios per contact with balance and performance data
- **Email Templates**: Create, edit, and manage email templates with dynamic shortcode replacement
- **Email Preview & Send**: Preview emails with real contact data before sending
- **Shortcode Support**: Dynamic content insertion using shortcodes like `{Contact.name}`, `{Organization.name}`, `{Portfolio.best_performance}`, etc.

## Tech Stack

- Ruby 3.3.5
- Rails 8.0.3
- PostgreSQL
- JavaScript
- RSpec for testing
- Shoulda Matchers

## Prerequisites

- Ruby 3.3.5 or higher
- PostgreSQL
- Bundler

## Setup Instructions

### 1. Clone the repository

```bash
git clone <repository-url>
cd portfolio_management_system
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Database setup

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Start the server

```bash
rails server
```

Visit `http://localhost:3000` in your browser.

## Running Tests

```bash
bundle exec rspec
```

Or run specific test files:

```bash
bundle exec rspec spec/models
```

## Database Schema

### Models and Relationships

- **Organization**: Has many contacts
  - `name` (string)
  - `email` (string)

- **Contact**: Belongs to organization, has many portfolios
  - `name` (string)
  - `email` (string)
  - `organization_id` (foreign key)

- **Portfolio**: Belongs to contact
  - `name` (string)
  - `balance` (decimal)
  - `performance` (decimal)
  - `contact_id` (foreign key)

- **EmailTemplate**: Standalone model
  - `subject` (string)
  - `body` (text)

## Shortcode System

The email template system supports the following shortcodes:

- `{Contact.name}` - Contact's full name
- `{Contact.email}` - Contact's email address
- `{Organization.name}` - Organization name
- `{Organization.email}` - Organization email
- `{Portfolio.best_performance}` - Best performing portfolio percentage
- `{Portfolio.worst_performance}` - Worst performing portfolio percentage

## Sample Data

After running `rails db:seed`, the system will have:

- 2 Organizations (Acme Corp, Globex Inc)
- 3 Contacts (Alice Johnson, Bob Smith, Carol White)
- 6 Portfolios with varying performance metrics
- 3 Email Templates with different use cases

## Application Routes

- `/` - Contacts Dashboard (root)
- `/contacts` - Contacts index
- `/email_templates` - Email templates index
- `/email_templates/new` - Create new template
- `/email_templates/:id` - View template details
- `/email_templates/:id/edit` - Edit template
- `/email_templates/:id/preview?contact_id=:contact_id` - Preview template for contact
- `/email_templates/:id/send_email?contact_id=:contact_id` - Send email to contact

## Key Features Implementation

### 1. Contacts Dashboard
- Lists all contacts with their organization details
- Shows all portfolios for each contact
- Displays best and worst portfolio performance
- Provides dropdown to select email templates
- Includes Preview and Send buttons for emails

### 2. Email Templates Management
- Full CRUD operations for email templates
- Template editor with shortcode hints
- Preview functionality with real contact data
- Simulated email sending with flash notifications

### 3. Shortcode Parsing
- Implemented in `EmailTemplate#render_for_contact` method
- Dynamically replaces shortcodes with actual contact data
- Works for both subject and body fields

## Assumptions

1. Email "sending" is simulated with flash messages (no actual SMTP integration)
2. Performance values are stored as percentages (15.0 means 15%)
3. Each contact must belong to an organization
4. Each portfolio must belong to a contact
5. Balance must be non-negative
6. Email validation uses standard Rails email format regex

## Testing Coverage

The test suite includes:

- Model associations testing
- Model validations testing
- Shortcode parsing logic testing
- Best/worst performance calculation testing

All tests pass successfully with 29 examples and 0 failures.

## Future Enhancements

- Actual email delivery via ActionMailer
- Multi-level organization hierarchy (parent/subsidiary relationships)
- Portfolio performance history tracking
- Advanced analytics and reporting
- User authentication and authorization
- Batch email sending
- Email scheduling
- Template version control

## License

This project is created as an assessment task.
