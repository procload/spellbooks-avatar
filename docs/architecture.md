# Spellbooks Avatar Generator - Architecture Overview

Welcome to the Spellbooks Avatar Generator! This document provides a comprehensive overview of the application's architecture, technology stack, and development practices. It's designed to help new engineers quickly understand how the system is organized and how everything works together.

## Table of Contents

1. [System Overview](#system-overview)
2. [Technology Stack](#technology-stack)
3. [Application Architecture](#application-architecture)
4. [Directory Structure](#directory-structure)
5. [Key Components](#key-components)
6. [Design Patterns & Principles](#design-patterns--principles)
7. [Data Flow](#data-flow)
8. [Development Workflow](#development-workflow)
9. [Testing Strategy](#testing-strategy)
10. [CI/CD Pipeline](#cicd-pipeline)
11. [Deployment](#deployment)
12. [Configuration Management](#configuration-management)
13. [AI Integration](#ai-integration)

---

## System Overview

The Spellbooks Avatar Generator is a kid-friendly web application built for the Spellbooks educational platform. It allows users (primarily children) to create personalized avatars by selecting various attributes like name, gender, class, and personality traits. The application uses AI-powered image generation to create consistent, high-quality avatar images.

**Key Features:**
- Simple, intuitive form-based interface
- AI-powered image generation using Google Gemini
- Mobile-first, responsive design
- Session-based avatar storage (no database persistence for user data)
- Background job processing for image generation
- AI-assisted development workflows

**Target Users:** Children ages 6-14 using the Spellbooks educational platform

---

## Technology Stack

### Backend Framework
- **Ruby on Rails 8.0.3**: Modern Rails leveraging the latest features including Solid Queue, Solid Cache, and Solid Cable
- **Ruby 3.3+**: Latest stable Ruby version

### Frontend
- **Hotwire Stack**:
  - **Turbo**: SPA-like page acceleration without writing JavaScript
  - **Stimulus**: Modest JavaScript framework for progressive enhancement
- **Importmap**: JavaScript without Node.js or bundling
- **Propshaft**: Modern asset pipeline

### Data Layer
- **SQLite3**: Lightweight database for development and production
  - Main application database (schema.rb shows version 0 - no ActiveRecord models yet)
  - Solid Queue database for background jobs
  - Solid Cache database for caching
  - Solid Cable database for ActionCable

### Background Processing
- **Solid Queue**: Rails 8's default background job processor
  - Configurable workers and dispatchers
  - Runs in-process with Puma in production via `SOLID_QUEUE_IN_PUMA=true`
  - Configuration in `config/queue.yml`

### AI Integration
- **Google Gemini 2.5**: Image generation API
- **OpenAI Codex**: Code generation and automation (via GitHub Actions)
- **Claude Code**: AI-powered code reviews (via GitHub Actions)

### HTTP Client
- **Faraday**: Flexible HTTP client for API integrations

### Deployment
- **Kamal**: Modern deployment tool from Basecamp
- **Docker**: Containerization
- **Puma**: Ruby web server

### Development & Testing
- **Minitest**: Rails default testing framework
- **Capybara + Selenium**: System/integration testing
- **RuboCop (Rails Omakase)**: Code style and linting
- **Brakeman**: Static security analysis

---

## Application Architecture

The application follows a **service-oriented architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                         Browser                              │
└──────────────────────┬──────────────────────────────────────┘
                       │ HTTP
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    Rails Router                              │
│                   (config/routes.rb)                         │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                 AvatarsController                            │
│           (app/controllers/avatars_controller.rb)            │
│                                                              │
│  - Form rendering (new, edit)                               │
│  - Form submission (create, update)                         │
│  - Session management                                        │
└──────────────┬───────────────────────┬──────────────────────┘
               │                       │
               ▼                       ▼
┌──────────────────────┐    ┌────────────────────────────────┐
│   Avatar Model       │    │  ImageGenerationJob            │
│  (app/models/        │    │  (app/jobs/                    │
│   avatar.rb)         │    │   image_generation_job.rb)     │
│                      │    │                                │
│ - Validations        │    │ - Async image generation       │
│ - Form object        │    │ - Retry logic                  │
│ - No persistence     │    │ - Error handling               │
└──────────────────────┘    └────────┬───────────────────────┘
                                     │
                                     ▼
                        ┌───────────────────────────────────┐
                        │  ImageGeneration::Client          │
                        │  (app/services/image_generation/  │
                        │   client.rb)                      │
                        │                                   │
                        │ - Orchestrates generation         │
                        │ - Loads prompts                   │
                        │ - Manages providers               │
                        └──────┬────────────────────────────┘
                               │
                               ▼
                ┌──────────────────────────────────────┐
                │  Provider Abstraction Layer          │
                ├──────────────────────────────────────┤
                │  ProviderRegistry                    │
                │  (Dynamic provider selection)        │
                └──────────┬───────────────────────────┘
                           │
                           ▼
                ┌─────────────────────────────┐
                │  Gemini Provider            │
                │  (app/services/             │
                │   image_generation/         │
                │   providers/gemini.rb)      │
                │                             │
                │ - API communication         │
                │ - Response parsing          │
                │ - Error handling            │
                └──────────┬──────────────────┘
                           │
                           ▼
                ┌─────────────────────────────┐
                │   Google Gemini API         │
                │   (External Service)        │
                └─────────────────────────────┘
```

---

## Directory Structure

```
spellbooks-avatar/
├── app/
│   ├── assets/              # Images and stylesheets
│   │   ├── images/         # SVG placeholders, icons
│   │   └── stylesheets/    # CSS files
│   ├── controllers/        # Request handling
│   │   ├── application_controller.rb
│   │   └── avatars_controller.rb
│   ├── helpers/            # View helpers
│   ├── javascript/         # Stimulus controllers
│   │   ├── application.js
│   │   └── controllers/    # Stimulus controllers
│   ├── jobs/               # Background jobs
│   │   ├── application_job.rb
│   │   └── image_generation_job.rb
│   ├── mailers/            # Email functionality
│   ├── models/             # Business logic
│   │   ├── application_record.rb
│   │   └── avatar.rb       # Form object (no DB persistence)
│   ├── services/           # Service objects
│   │   └── image_generation/
│   │       ├── client.rb
│   │       ├── configuration.rb
│   │       ├── prompt_loader.rb
│   │       ├── provider_registry.rb
│   │       ├── reference_image_builder.rb
│   │       └── providers/
│   │           └── gemini.rb
│   └── views/              # Templates
│       ├── avatars/
│       │   ├── new.html.erb
│       │   ├── edit.html.erb
│       │   ├── _form.html.erb
│       │   └── _submission_summary.html.erb
│       └── layouts/
│           └── application.html.erb
│
├── config/                 # Application configuration
│   ├── application.rb
│   ├── routes.rb
│   ├── database.yml        # SQLite configuration
│   ├── queue.yml           # Solid Queue configuration
│   ├── cache.yml           # Solid Cache configuration
│   ├── cable.yml           # Solid Cable configuration
│   ├── deploy.yml          # Kamal deployment config
│   ├── image_generation.yml # Image gen settings
│   ├── prompts/            # AI prompt templates
│   │   └── avatar.yml
│   ├── environments/       # Environment-specific configs
│   └── initializers/       # Initialization code
│
├── db/                     # Database files
│   ├── schema.rb           # Main database schema
│   ├── queue_schema.rb     # Solid Queue schema
│   ├── cache_schema.rb     # Solid Cache schema
│   ├── cable_schema.rb     # Solid Cable schema
│   └── seeds.rb            # Seed data
│
├── docs/                   # Documentation
│   ├── prd.md              # Product requirements
│   ├── setup.md            # Setup instructions
│   ├── gemini_image_generation_plan.md
│   └── architecture.md     # This file
│
├── test/                   # Test suite
│   ├── controllers/
│   ├── models/
│   ├── services/
│   ├── jobs/
│   ├── system/
│   ├── fixtures/
│   ├── test_helper.rb
│   └── application_system_test_case.rb
│
├── .github/
│   └── workflows/          # GitHub Actions
│       ├── ci.yml          # Main CI pipeline
│       ├── codex.yml       # OpenAI Codex automation
│       ├── claude.yml      # Claude Code assistance
│       └── claude-code-review.yml
│
├── bin/                    # Executable scripts
├── public/                 # Static assets
├── storage/                # Active Storage files
├── tmp/                    # Temporary files
├── .kamal/                 # Kamal deployment hooks
├── Dockerfile              # Container definition
├── Gemfile                 # Gem dependencies
├── AGENTS.md               # AI agent guidelines
└── README.md               # Project overview
```

---

## Key Components

### 1. Controllers

#### `AvatarsController`
- **Location**: `app/controllers/avatars_controller.rb`
- **Responsibilities**:
  - Render avatar creation form (`new`)
  - Render avatar editing form (`edit`)
  - Process form submissions (`create`, `update`)
  - Manage avatar data in session (no database persistence)
  - Validate form inputs via `Avatar` model

**Key Methods:**
- `new`: Initialize new avatar form
- `create`: Validate and save avatar to session
- `edit`: Load existing avatar from session
- `update`: Update avatar in session
- `assign_form_options`: Provide dropdown options (classes, traits, genders)
- `persist_avatar`: Store avatar in session
- `current_avatar_attributes`: Retrieve avatar from session

### 2. Models

#### `Avatar`
- **Location**: `app/models/avatar.rb`
- **Type**: Form Object (not an ActiveRecord model)
- **Responsibilities**:
  - Define avatar attributes (name, gender, klass, traits)
  - Validate user input
  - Provide default values
  - Convert to hash for storage

**Attributes:**
- `name`: String (max 50 characters)
- `gender`: String (male, female, non-binary)
- `klass`: String (Wizard, Knight, Ranger, Scholar)
- `traits`: Array (Brave, Clever, Kind, Sneaky, Curious)

**Constants:**
- `CLASSES`: Available character classes
- `TRAITS`: Available personality traits
- `GENDERS`: Available gender options

### 3. Services

The `ImageGeneration` module provides a clean abstraction for AI image generation:

#### `ImageGeneration::Client`
- **Location**: `app/services/image_generation/client.rb`
- **Responsibilities**:
  - Orchestrate the image generation process
  - Coordinate prompt loading, provider selection, and generation
  - Inject dependencies (configuration, prompt loader, provider registry)

#### `ImageGeneration::Configuration`
- **Location**: `app/services/image_generation/configuration.rb`
- **Responsibilities**:
  - Load configuration from `config/image_generation.yml`
  - Provide environment-specific settings
  - Manage API keys and provider settings

#### `ImageGeneration::PromptLoader`
- **Location**: `app/services/image_generation/prompt_loader.rb`
- **Responsibilities**:
  - Load prompt templates from `config/prompts/avatar.yml`
  - Render prompts with ERB templating
  - Interpolate avatar attributes into prompts

#### `ImageGeneration::ProviderRegistry`
- **Location**: `app/services/image_generation/provider_registry.rb`
- **Responsibilities**:
  - Register and resolve image generation providers
  - Enable provider switching without code changes
  - Support multiple provider implementations

#### `ImageGeneration::Providers::Gemini`
- **Location**: `app/services/image_generation/providers/gemini.rb`
- **Responsibilities**:
  - Communicate with Google Gemini API
  - Transform generic prompts to Gemini-specific format
  - Handle API responses and errors
  - Apply safety settings and generation config

#### `ImageGeneration::ReferenceImageBuilder`
- **Location**: `app/services/image_generation/reference_image_builder.rb`
- **Responsibilities**:
  - Build reference images from signed IDs
  - Support example images for style consistency

### 4. Jobs

#### `ImageGenerationJob`
- **Location**: `app/jobs/image_generation_job.rb`
- **Type**: ActiveJob (backed by Solid Queue)
- **Responsibilities**:
  - Generate avatar images asynchronously
  - Retry on transient failures (timeouts, connection errors)
  - Discard on permanent failures (API errors, invalid data)

**Retry Strategy:**
- Retries on `Faraday::TimeoutError` and `Faraday::ConnectionFailed`
- Exponential backoff (3 attempts)
- Discards on provider errors or invalid inputs

### 5. Views

All views use Rails ERB templates with Hotwire for interactivity:

- **`avatars/new.html.erb`**: Main avatar creation page
- **`avatars/edit.html.erb`**: Avatar editing page
- **`avatars/_form.html.erb`**: Shared form partial
- **`avatars/_submission_summary.html.erb`**: Display submitted avatar details

**View Features:**
- Mobile-responsive design
- Turbo-powered form submissions (no page reloads)
- Simple, kid-friendly UI
- Placeholder avatar image (SVG)

---

## Design Patterns & Principles

### 1. Form Objects
The `Avatar` model is a **form object** pattern using `ActiveModel::Model` instead of `ActiveRecord`. This provides validation and attribute handling without database persistence.

**Benefits:**
- Clean separation between form validation and data storage
- No database overhead for simple session-based data
- Easy to test and maintain

### 2. Service Objects
Complex business logic is extracted into service objects under `app/services/`:

**Benefits:**
- Controllers stay thin and focused on HTTP concerns
- Business logic is reusable and testable
- Clear single responsibility

### 3. Provider Pattern
The `ProviderRegistry` and provider implementations follow the **Strategy Pattern**:

**Benefits:**
- Easy to add new image generation providers
- Configuration-based provider switching
- Provider-agnostic business logic

### 4. Dependency Injection
Services accept dependencies through constructor injection:

```ruby
def initialize(configuration: Configuration.new,
               prompt_loader: PromptLoader.new,
               reference_image_builder: ReferenceImageBuilder.new,
               provider_registry: nil)
```

**Benefits:**
- Easier testing with mocks
- Flexible composition
- Explicit dependencies

### 5. Rails Omakase
The project follows **Rails Omakase** philosophy:
- Convention over configuration
- Minimal external dependencies
- Use Rails 8's built-in tools (Solid Queue, Solid Cache, Solid Cable)
- Progressive enhancement with Hotwire

### 6. Configuration as Code
All configuration lives in YAML files:
- `config/image_generation.yml`: Image generation settings
- `config/prompts/avatar.yml`: AI prompt templates
- `config/queue.yml`: Background job configuration

**Benefits:**
- Environment-specific overrides
- Version-controlled configuration
- No hardcoded values

---

## Data Flow

### Avatar Creation Flow

1. **User visits** `/` (root_path)
   - Routes to `AvatarsController#new`
   - Controller initializes empty `@avatar_form`
   - Renders `avatars/new.html.erb` with form

2. **User fills form** and clicks "Generate"
   - Form submits to `AvatarsController#create` (POST /avatar)
   - Controller creates `Avatar` instance with params
   - Validates form object

3. **If validation succeeds:**
   - Controller saves avatar to session
   - Redirects back to `new` action
   - Form shows submitted avatar summary

4. **If validation fails:**
   - Controller re-renders form with errors
   - Returns 422 Unprocessable Entity status

### Image Generation Flow (Future)

When image generation is fully integrated:

1. **Avatar validated** in controller
2. **Job enqueued**: `ImageGenerationJob.perform_later(...)`
3. **Solid Queue** picks up job
4. **Job executes**:
   - Calls `ImageGeneration::Client#generate`
   - Client loads prompt template
   - Client resolves provider (Gemini)
   - Provider makes API call to Google Gemini
   - Provider parses response
5. **Image returned** and stored (Active Storage)
6. **User notified** via Turbo Stream or redirect

---

## Development Workflow

### Initial Setup

```bash
# Clone repository
git clone https://github.com/procload/spellbooks-avatar.git
cd spellbooks-avatar

# Install dependencies and prepare database
bin/setup

# Start development server
bin/rails server
# Visit http://localhost:3000
```

### Development Commands

```bash
# Start Rails server
bin/rails server

# Run console
bin/rails console

# Run full test suite
bin/rails test

# Run specific test file
bin/rails test test/models/avatar_test.rb

# Run system tests
bin/rails test:system

# Lint code (check style)
bundle exec rubocop

# Lint code (auto-fix safe issues)
bundle exec rubocop -A

# Security scan
bundle exec brakeman

# Database operations
bin/rails db:migrate
bin/rails db:prepare
bin/rails db:reset
```

### Code Style

The project uses **Rails Omakase** style via RuboCop:
- Two-space indentation
- `snake_case` for methods and variables
- `CamelCase` for classes and modules
- No line length limits (omakase relaxes this)
- Run `rubocop -A` before committing

### Git Workflow

1. Create a new branch for features/fixes
2. Write tests first (TDD encouraged)
3. Make minimal changes to pass tests
4. Run linters and tests locally
5. Commit with short, imperative messages (≤ 50 chars)
6. Push and open pull request
7. CI runs automatically (tests, linters, security scans)
8. Request review
9. Merge after approval

---

## Testing Strategy

### Test Framework: Minitest

The project uses Rails' default testing framework (Minitest) with:
- **Fixtures**: Test data in `test/fixtures/`
- **Parallel execution**: Tests run in parallel by default
- **System tests**: Capybara + Selenium for browser automation

### Test Types

#### 1. Model Tests
**Location**: `test/models/avatar_test.rb`

Tests for the `Avatar` form object:
- Validation rules
- Attribute handling
- Default values
- Serialization (`to_h`)

#### 2. Controller Tests
**Location**: `test/controllers/avatars_controller_test.rb`

Tests for HTTP request/response:
- GET requests render forms
- POST requests create/update avatars
- Validation errors return 422 status
- Session management

#### 3. Service Tests
**Location**: `test/services/image_generation/`

Tests for image generation services:
- Client orchestration
- Configuration loading
- Prompt rendering
- Provider registry
- API communication (mocked with VCR/WebMock)

#### 4. Job Tests
**Location**: `test/jobs/image_generation_job_test.rb`

Tests for background jobs:
- Job enqueueing
- Retry logic
- Error handling
- Discard conditions

#### 5. System Tests
**Location**: `test/system/`

End-to-end browser tests:
- Full user workflows
- JavaScript interactions
- Form submissions
- Visual feedback

### Running Tests

```bash
# All tests
bin/rails test

# Specific file
bin/rails test test/models/avatar_test.rb

# Specific test
bin/rails test test/models/avatar_test.rb:10

# System tests only
bin/rails test:system

# With coverage (if configured)
COVERAGE=true bin/rails test
```

### Test Best Practices

- Keep tests fast (use mocks for external APIs)
- One assertion per test (when possible)
- Descriptive test names
- Test edge cases and error paths
- Use fixtures or factories consistently
- Clean up test data after runs

---

## CI/CD Pipeline

### GitHub Actions Workflows

Located in `.github/workflows/`:

#### 1. `ci.yml` - Main CI Pipeline
Runs on every push and pull request:

**Jobs:**
- `scan_ruby`: Brakeman security scan
- `scan_js`: JavaScript dependency audit (importmap)
- `lint`: RuboCop style check
- `test`: Full test suite (model, controller, service, system tests)

**Test Environment:**
- Ubuntu latest
- Ruby from `.ruby-version`
- Chrome for system tests
- SQLite database

**Artifacts:**
- Failed system test screenshots

#### 2. `codex.yml` - OpenAI Codex Automation
Triggered by `@codex` mentions in issues:
- Code generation
- Automated PR creation
- Issue handling

#### 3. `claude.yml` - Claude Code Assistance
Triggered by `@claude` mentions:
- Code review
- Architectural suggestions
- Documentation improvements

#### 4. `claude-code-review.yml`
Automated code review on pull requests

### CI/CD Flow

```
┌──────────────┐
│  Git Push    │
└──────┬───────┘
       │
       ▼
┌──────────────────────────────┐
│  GitHub Actions Triggered    │
└──────┬───────────────────────┘
       │
       ├─► Security Scan (Brakeman)
       ├─► JS Audit (importmap)
       ├─► Lint (RuboCop)
       └─► Tests (Minitest)
              │
              ├─► Model tests
              ├─► Controller tests
              ├─► Service tests
              ├─► Job tests
              └─► System tests
                     │
                     ▼
              ┌──────────────┐
              │   Success    │ ─► Merge allowed
              └──────────────┘
                     │
                     ▼
              ┌──────────────┐
              │   Failure    │ ─► Fix required
              └──────────────┘
```

---

## Deployment

### Kamal Deployment

The application uses **Kamal** for Docker-based deployment:

**Configuration**: `config/deploy.yml`

#### Key Settings:

- **Service name**: `spellbooks_avatar`
- **Web servers**: Configurable in `servers.web`
- **Registry**: Docker Hub (or custom registry)
- **SSL**: Auto-certification with Let's Encrypt
- **Volumes**: Persistent storage for SQLite and Active Storage

#### Environment Variables:

**Secrets** (from `.kamal/secrets`):
- `RAILS_MASTER_KEY`: Rails credentials key
- `KAMAL_REGISTRY_PASSWORD`: Docker registry password

**Clear** (environment settings):
- `SOLID_QUEUE_IN_PUMA=true`: Run Solid Queue in Puma process
- `JOB_CONCURRENCY`: Number of job worker processes
- `WEB_CONCURRENCY`: Number of Puma worker processes
- `DB_HOST`: Database host (if using external database)

#### Deployment Commands:

```bash
# Initial setup
kamal setup

# Deploy application
kamal deploy

# Open Rails console on server
kamal console

# View logs
kamal logs

# SSH into container
kamal shell

# Roll back deployment
kamal rollback

# Database console
kamal dbc
```

#### Deployment Flow:

1. **Build**: Docker image built with Dockerfile
2. **Push**: Image pushed to registry
3. **Pull**: Server pulls new image
4. **Deploy**: Container started with new image
5. **Health check**: `/up` endpoint verified
6. **Proxy**: Traffic routed to new container
7. **Cleanup**: Old containers removed

---

## Configuration Management

### Rails Credentials

Sensitive data stored in encrypted credentials:

```bash
# Edit credentials
bin/rails credentials:edit

# Structure
RAILS_MASTER_KEY=...
gemini:
  api_key: xxx
openai:
  api_key: xxx
anthropic:
  api_key: xxx
```

### Environment-Based Configuration

#### `config/image_generation.yml`
```yaml
development:
  provider: gemini
  gemini:
    api_key: <%= ENV.fetch("GEMINI_API_KEY") %>
    endpoint: https://generativelanguage.googleapis.com/...
    model: gemini-2.0-nano-banana
```

#### `config/queue.yml`
```yaml
production:
  workers:
    - queues: "*"
      threads: 3
      processes: <%= ENV.fetch("JOB_CONCURRENCY", 1) %>
```

### Database Configuration

SQLite for all environments (`config/database.yml`):
- **Development**: `db/development.sqlite3`
- **Test**: `db/test.sqlite3`
- **Production**: `db/production.sqlite3` (persistent volume in Kamal)

Separate SQLite databases for:
- Main app data
- Solid Queue jobs
- Solid Cache entries
- Solid Cable messages

---

## AI Integration

### Google Gemini (Image Generation)

**Purpose**: Generate avatar images from text prompts

**Configuration**: `config/image_generation.yml`

**Prompt Templates**: `config/prompts/avatar.yml`

**Usage**:
```ruby
ImageGenerationJob.perform_later(
  template: "avatar",
  attributes: { name: "Astra", class: "Wizard", traits: ["Clever"] }
)
```

### OpenAI Codex (Development Automation)

**Purpose**: Automated code generation and PR creation

**Trigger**: `@codex` mention in GitHub issues or `[codex]` prefix in issue titles

**Capabilities**:
- Generate boilerplate code
- Create pull requests
- Implement feature requests
- Fix bugs

### Claude Code (Code Review)

**Purpose**: AI-powered code review and assistance

**Triggers**:
- `@claude` mention in issues/PRs
- Automatic on pull request creation (via `claude-code-review.yml`)

**Capabilities**:
- Code review with suggestions
- Architecture recommendations
- Documentation improvements
- Bug detection

### AI-Assisted Development Workflow

1. **Create issue** describing feature/bug
2. **Mention AI agent**: `@codex` or `@claude`
3. **Agent processes** request
4. **PR created** automatically (Codex) or review provided (Claude)
5. **Human review** and merge

---

## Appendix: Key Files Reference

### Configuration Files

| File | Purpose |
|------|---------|
| `config/routes.rb` | URL routing |
| `config/application.rb` | Rails application config |
| `config/database.yml` | Database configuration |
| `config/image_generation.yml` | Image gen settings |
| `config/queue.yml` | Solid Queue config |
| `config/cache.yml` | Solid Cache config |
| `config/cable.yml` | Solid Cable config |
| `config/deploy.yml` | Kamal deployment |
| `config/prompts/avatar.yml` | AI prompt templates |
| `.rubocop.yml` | RuboCop linting rules |
| `Gemfile` | Ruby gem dependencies |
| `Dockerfile` | Container definition |

### Key Source Files

| File | Purpose |
|------|---------|
| `app/controllers/avatars_controller.rb` | Main controller |
| `app/models/avatar.rb` | Avatar form object |
| `app/jobs/image_generation_job.rb` | Background job |
| `app/services/image_generation/client.rb` | Image gen orchestration |
| `app/services/image_generation/providers/gemini.rb` | Gemini API integration |

### Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Project overview |
| `AGENTS.md` | AI agent guidelines |
| `docs/prd.md` | Product requirements |
| `docs/setup.md` | Setup instructions |
| `docs/architecture.md` | This document |
| `docs/gemini_image_generation_plan.md` | Image gen architecture |

---

## Getting Help

- **Documentation**: Check `docs/` directory
- **Code examples**: Look at test files
- **AI assistance**: Mention `@claude` in issues
- **Team**: Ask questions in pull requests

Welcome to the team! 🎉
