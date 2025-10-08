# Spellbooks Avatar Generator - Architecture Overview

Welcome to the Spellbooks Avatar Generator! This document provides a comprehensive overview of the system architecture, technology stack, and development practices to help you get up to speed quickly.

## Table of Contents
1. [System Overview](#system-overview)
2. [Technology Stack](#technology-stack)
3. [Project Structure](#project-structure)
4. [Core Components](#core-components)
5. [Data Flow](#data-flow)
6. [AI Integration Architecture](#ai-integration-architecture)
7. [Development Workflow](#development-workflow)
8. [Testing Strategy](#testing-strategy)
9. [Deployment & CI/CD](#deployment--cicd)
10. [Key Patterns & Conventions](#key-patterns--conventions)

## System Overview

The Spellbooks Avatar Generator is a kid-friendly web application that allows users to create personalized avatars for the Spellbooks educational platform. The application combines a simple Rails backend with AI-powered image generation to create fun, consistent avatar designs.

### Key Design Principles
- **Simplicity First**: Minimal UI optimized for kids and mobile devices
- **AI-Powered Development**: Integrated code review and automation via GitHub Actions
- **Provider Flexibility**: Pluggable architecture for switching image generation providers
- **Session-Based State**: No database persistence required for core functionality

## Technology Stack

### Backend Framework
- **Ruby 3.3+** - Modern Ruby version with performance improvements
- **Rails 8.0.3** - Latest Rails with Hotwire, modern asset pipeline, and solid libraries
- **SQLite3** - Lightweight database (development/testing only, no models currently)

### Frontend Stack
- **Hotwire** - Rails' answer to SPA experiences without heavy JavaScript
  - **Turbo**: Page navigation without full reloads
  - **Stimulus**: Modest JavaScript framework for sprinkles of interactivity
- **Propshaft**: Modern asset pipeline (simpler than Sprockets)
- **Importmap**: JavaScript module management without bundlers

### Backend Infrastructure (Rails 8 Solid Stack)
- **Solid Cache**: Database-backed caching layer
- **Solid Queue**: Background job processing without Redis
- **Solid Cable**: WebSocket connections for real-time features

### AI & External Services
- **Image Generation**: Pluggable providers (Google Gemini 2.5 + OpenAI GPT Image)
- **Faraday**: HTTP client for API integrations
- **OpenAI Codex**: Automated code generation via GitHub Actions
- **Claude Code**: AI-powered code review via GitHub Actions

### Development & Quality Tools
- **RuboCop (Rails Omakase)**: Consistent Ruby styling
- **Brakeman**: Static security analysis
- **Minitest**: Testing framework (Rails default)
- **Capybara + Selenium**: System/browser testing

### Deployment
- **Kamal**: Docker-based deployment tool
- **Thruster**: HTTP asset caching/compression for Puma

## Project Structure

```
spellbooks-avatar/
├── app/
│   ├── assets/              # Images, stylesheets
│   ├── controllers/         # HTTP request handlers
│   │   ├── concerns/        # Shared controller logic
│   │   └── avatars_controller.rb
│   ├── helpers/             # View helpers
│   ├── javascript/          # Stimulus controllers & JS
│   │   └── controllers/     # Stimulus controllers
│   ├── jobs/                # Background jobs
│   ├── mailers/             # Email templates & logic
│   ├── models/              # Domain models (ActiveModel)
│   │   ├── concerns/        # Shared model logic
│   │   └── avatar.rb        # Form object (no DB)
│   ├── services/            # Business logic & integrations
│   │   └── image_generation/ # Image generation subsystem
│   └── views/               # ERB templates
│       ├── avatars/         # Avatar-related views
│       └── layouts/         # Application layouts
│
├── config/
│   ├── environments/        # Environment-specific settings
│   ├── initializers/        # Rails initialization code
│   ├── application.rb       # Main app configuration
│   ├── database.yml         # Database configuration
│   ├── routes.rb            # URL routing
│   └── credentials.yml.enc  # Encrypted secrets
│
├── db/
│   ├── migrate/             # Database migrations
│   ├── schema.rb            # Current database schema
│   └── seeds.rb             # Sample data
│
├── test/
│   ├── controllers/         # Controller tests
│   ├── models/              # Model tests
│   ├── services/            # Service tests
│   ├── system/              # End-to-end browser tests
│   ├── fixtures/            # Test data
│   └── test_helper.rb       # Test configuration
│
├── docs/                    # Documentation
│   ├── prd.md              # Product requirements
│   ├── setup.md            # Setup instructions
│   └── gemini_image_generation_plan.md
│
├── .github/
│   └── workflows/          # GitHub Actions CI/CD
│       ├── ci.yml          # Main CI pipeline
│       ├── claude.yml      # Claude Code integration
│       └── codex.yml       # Codex integration
│
├── bin/                    # Executable scripts
│   ├── setup              # Initial setup script
│   ├── rails              # Rails command
│   └── rubocop            # Linting
│
└── public/                # Static files
```

## Core Components

### 1. Avatar Model (`app/models/avatar.rb`)

The Avatar is a **form object** using ActiveModel (not ActiveRecord - no database table). It handles validation and data structuring for avatar attributes.

**Key Attributes:**
- `name` (string): Avatar name, max 50 characters
- `gender` (string): One of "male", "female", or "non-binary"
- `klass` (string): Character class (Wizard, Knight, Ranger, Scholar)
- `traits` (array): Multiple traits (Brave, Clever, Kind, Sneaky, Curious)

**Key Features:**
- Input validation with inclusion checks
- Custom traits validation
- `to_h` method for serialization
- `defaults` class method for preset values

```ruby
# Usage example
avatar = Avatar.new(name: "Luna", gender: "female", klass: "Wizard", traits: ["Clever", "Curious"])
avatar.valid? # => true
avatar.to_h   # => { name: "Luna", gender: "female", ... }
```

### 2. Avatars Controller (`app/controllers/avatars_controller.rb`)

Handles the avatar creation and editing flow using **session-based persistence** (no database writes).

**Key Actions:**
- `new` - Display avatar creation form
- `create` - Validate and persist to session, redirect to new
- `edit` - Display avatar editing form with current data
- `update` - Update session data, redirect to edit

**Session Management:**
- `persist_avatar(avatar)` - Stores avatar hash in session
- `current_avatar_attributes` - Retrieves avatar from session safely

**Routes:**
```ruby
root "avatars#new"                    # GET /
resource :avatar, only: [:new, :create, :edit, :update]
```

### 3. Image Generation Service (`app/services/image_generation/`)

A **provider-agnostic architecture** for AI image generation with multiple components:

#### Client (`client.rb`)
- Main entry point for generating images
- Coordinates prompt loading, provider selection, and image generation
- Dependency injection for testability

#### Configuration (`configuration.rb`)
- Manages provider settings, API keys, and options
- Environment-specific configuration

#### Provider Registry (`provider_registry.rb`)
- Resolves and instantiates providers by name
- Supports provider switching at runtime

#### Prompt Loader (`prompt_loader.rb`)
- Loads and interpolates prompt templates
- Separates creative content from code

#### Reference Image Builder (`reference_image_builder.rb`)
- Builds reference images from Active Storage signed IDs
- Supports style transfer and guided generation

#### Providers (`providers/`)
- **Gemini Provider** (`providers/gemini.rb`): Google Gemini integration
- **OpenAI Provider** (`providers/open_ai.rb`): GPT Image integration (`gpt-image-1-mini` default)

**Usage Pattern:**
```ruby
client = ImageGeneration::Client.new
result = client.generate(
  template: 'avatar',
  attributes: { klass: 'Wizard', traits: ['Clever'] },
  provider: 'gemini'  # Optional, uses default if omitted
)
```

### 4. View Layer

**Partials:**
- `_form.html.erb` - Reusable avatar form with dropdowns and radio buttons
- `_submission_summary.html.erb` - Display submitted avatar details

**Pages:**
- `new.html.erb` - Avatar creation page
- `edit.html.erb` - Avatar editing page

**Form Features:**
- Turbo integration for partial page updates
- Mobile-first responsive design
- Accessible form controls

## Data Flow

### Avatar Creation Flow

```
1. User visits root (/) → AvatarsController#new
   ↓
2. Renders form with empty Avatar model
   ↓
3. User submits form → AvatarsController#create
   ↓
4. Validates Avatar model
   ↓
   ├─ Valid: Store in session → Redirect to #new with data
   └─ Invalid: Re-render form with errors
   ↓
5. Display form with submitted avatar summary
```

### Image Generation Flow (Planned)

```
1. User submits avatar form
   ↓
2. Controller creates Avatar model
   ↓
3. Enqueue ImageGeneration::Job (background)
   ↓
4. Job calls ImageGeneration::Client
   ↓
5. Client loads prompt template
   ↓
6. Client selects provider (Gemini)
   ↓
7. Provider makes API call
   ↓
8. Save result to Active Storage
   ↓
9. Update UI via Turbo Stream (real-time)
```

## AI Integration Architecture

### GitHub Actions Integration

The repository uses AI agents for automated development assistance:

#### 1. Claude Code (`@claude` mention)
- **Trigger**: `@claude` in issues/PRs or PR reviews
- **Workflow**: `.github/workflows/claude.yml` and `claude-code-review.yml`
- **Purpose**: Code review, suggestions, implementation assistance
- **Config**: Uses `ANTHROPIC_API_KEY` secret

#### 2. Codex (`@codex` mention)
- **Trigger**: `@codex` in issues/PRs or `[codex]` in issue title
- **Workflow**: `.github/workflows/codex.yml`
- **Purpose**: Code generation and automation
- **Config**: Uses `OPENAI_API_KEY` secret

#### 3. CI Pipeline (`.github/workflows/ci.yml`)
- **Security Scanning**: Brakeman (Ruby), Importmap audit (JavaScript)
- **Linting**: RuboCop with Rails Omakase style
- **Testing**: Full test suite including system tests
- **Runs on**: PRs and pushes to main

### AI Development Workflow

```
1. Create issue describing feature/bug
   ↓
2. Mention @claude or @codex for AI assistance
   ↓
3. AI analyzes codebase and suggests implementation
   ↓
4. AI creates PR with changes
   ↓
5. CI runs (lint, security, tests)
   ↓
6. Human reviews and merges
```

## Development Workflow

### Getting Started

```bash
# Clone repository
git clone https://github.com/procload/spellbooks-avatar.git
cd spellbooks-avatar

# Run setup (installs gems, prepares DB, compiles assets)
bin/setup

# Start development server
bin/rails server
# Visit http://localhost:3000
```

### Environment Variables

Configure in Rails credentials or environment:
- `OPENAI_API_KEY` - For Codex integration and OpenAI image generation
- `ANTHROPIC_API_KEY` - For Claude Code integration
- `IMAGE_MODEL_API_KEY` - Default API key for avatar generation
- `IMAGE_MODEL_PROVIDER` - Switch between `gemini` and `openai`
- `IMAGE_MODEL_NAME` - Override the configured model identifier (e.g., `gpt-image-1-mini`)

Edit credentials:
```bash
bin/rails credentials:edit
```

### Common Commands

```bash
# Development server
bin/rails server

# Run all tests
bin/rails test
bin/rails test:system

# Specific test file
bin/rails test test/models/avatar_test.rb

# Linting
bundle exec rubocop          # Check style
bundle exec rubocop -A       # Auto-fix safe issues

# Security scan
bundle exec brakeman

# Database
bin/rails db:prepare         # Setup database
bin/rails db:migrate         # Run migrations
bin/rails db:reset          # Reset database

# Console
bin/rails console            # Interactive Ruby console
```

## Testing Strategy

### Test Organization

- **Unit Tests** (`test/models/`, `test/services/`)
  - Test individual models and services in isolation
  - Use fixtures or plain Ruby objects

- **Controller Tests** (`test/controllers/`)
  - Test HTTP request/response behavior
  - Verify redirects, status codes, session handling

- **System Tests** (`test/system/`)
  - End-to-end browser testing with Capybara
  - Verify user workflows and JavaScript interactions

### Testing Framework: Minitest

Rails default testing framework with a simple, fast approach:

```ruby
# Model test example
class AvatarTest < ActiveSupport::TestCase
  test "validates presence of name" do
    avatar = Avatar.new(gender: "female", klass: "Wizard")
    assert_not avatar.valid?
    assert_includes avatar.errors[:name], "can't be blank"
  end
end

# System test example
class AvatarsTest < ApplicationSystemTestCase
  test "creating an avatar" do
    visit root_path
    fill_in "Name", with: "Luna"
    choose "female"
    select "Wizard", from: "Class"
    click_button "Generate"

    assert_text "Luna"
    assert_text "Wizard"
  end
end
```

### Test Fixtures

Located in `test/fixtures/` - provide sample data for tests.

### Running Tests

```bash
# All tests
bin/rails test

# Specific test type
bin/rails test:models
bin/rails test:controllers
bin/rails test:system

# Single file
bin/rails test test/models/avatar_test.rb

# Single test
bin/rails test test/models/avatar_test.rb:6
```

## Deployment & CI/CD

### Continuous Integration

The CI pipeline runs on every PR and push to main:

1. **Security Scans**
   - Brakeman: Static analysis for Rails vulnerabilities
   - Importmap audit: JavaScript dependency vulnerabilities

2. **Code Quality**
   - RuboCop: Enforces Rails Omakase style guide

3. **Tests**
   - Unit tests, controller tests, system tests
   - Screenshots saved on system test failures

### Deployment (Kamal)

Kamal provides zero-downtime Docker deployments:

```bash
# Deploy to production
kamal deploy

# Check deployment status
kamal app details

# View logs
kamal app logs

# Rollback
kamal app rollback
```

Configuration in `.kamal/` directory.

### Docker

Dockerfile includes:
- Ruby 3.3 base image
- Rails app with dependencies
- Asset compilation
- Production-ready configuration

## Key Patterns & Conventions

### Coding Style

**Ruby Conventions:**
- Two-space indentation
- `snake_case` for methods and variables
- `CamelCase` for classes and modules
- Rails Omakase style guide (RuboCop enforced)

**Controller Guidelines:**
- Keep controllers thin
- Move business logic to models or services
- Use `before_action` for shared setup
- Prefer strong parameters for security

**Service Objects:**
- Place in `app/services/`
- One responsibility per service
- Dependency injection for testability
- Return value objects or raise exceptions

### File Naming

**Stimulus Controllers:**
- Filename matches class name: `avatar_controller.js` → `AvatarController`
- Place in `app/javascript/controllers/`
- Register automatically via `index.js`

**Tests:**
- Pattern: `<subject>_test.rb`
- Class name: `<Subject>Test`
- Use descriptive test names: `test "should validate presence of name"`

### Git & Commits

**Commit Messages:**
- Keep subject line ≤ 50 characters
- Use imperative mood: "Add feature" not "Added feature"
- Reference issues: `Fixes #123` or `Relates to #456`
- Include details in body for complex changes

**Example:**
```
Add avatar traits validation

- Validates traits against allowed list
- Provides clear error messages
- Updates tests for new validation

Fixes #42
```

### Security Best Practices

1. **Credentials Management**
   - Use Rails credentials (`bin/rails credentials:edit`)
   - Never commit plaintext secrets
   - Environment-specific credentials in `config/credentials/`

2. **Input Validation**
   - Always use strong parameters in controllers
   - Validate all user input in models
   - Sanitize HTML output (Rails does this by default)

3. **File Uploads** (when implemented)
   - Validate file size limits
   - Check content types
   - Use Active Storage with virus scanning

4. **API Security**
   - Rate limit external API calls
   - Handle API failures gracefully
   - Log security events

## Roadmap & Future Enhancements

### Current Status (Week 1-2)
- ✅ Rails 8 application setup
- ✅ Basic avatar form UI
- ✅ GitHub Actions integration
- ✅ Avatar model with validations
- ✅ Session-based persistence
- 🚧 Image generation service (in progress)

### Planned Features

**Week 3: Image Generation**
- Gemini API integration
- Prompt template system
- Background job processing
- Image storage with Active Storage

**Week 4: Authentication & Storage**
- Devise user authentication
- Database persistence
- User avatar galleries
- Spellbooks platform integration

**Future Enhancements:**
- Multiple art styles
- Avatar customization editor
- Social sharing features
- Advanced trait combinations

## Additional Resources

### Documentation
- [Product Requirements (PRD)](docs/prd.md) - Detailed product specs
- [Setup Guide](docs/setup.md) - Step-by-step setup instructions
- [Gemini Integration Plan](docs/gemini_image_generation_plan.md) - Image generation architecture
- [Repository Guidelines (AGENTS.md)](AGENTS.md) - Development guidelines

### External Resources
- [Rails 8 Guides](https://guides.rubyonrails.org/) - Official Rails documentation
- [Hotwire Handbook](https://hotwired.dev/) - Turbo and Stimulus guides
- [Kamal Deployment](https://kamal-deploy.org/) - Deployment documentation
- [Rails Omakase](https://github.com/rails/rubocop-rails-omakase) - Style guide

## Getting Help

### Development Issues
1. Check existing documentation in `docs/`
2. Review AGENTS.md for coding guidelines
3. Create an issue with `@claude` or `@codex` mention for AI assistance

### Testing Issues
- System test screenshots saved in `tmp/screenshots/` on failure
- CI failures include detailed logs in GitHub Actions
- Use `bin/rails test:system HEADLESS=false` to see browser tests

### Deployment Issues
- Check Kamal logs: `kamal app logs`
- Verify environment variables are set
- Review Dockerfile for build issues

---

**Welcome to the team! 🎨✨**

This architecture is designed to be simple, maintainable, and fun to work with. Don't hesitate to ask questions or suggest improvements. Happy coding!
