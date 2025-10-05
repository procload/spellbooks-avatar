# Spellbooks Avatar Generator

A kid-friendly web application for creating personalized avatars for the Spellbooks educational platform. This mini-app leverages AI-powered image generation to create fun, consistent avatar designs.

## Overview

The Spellbooks Avatar Generator is designed to provide a simple, engaging experience for children to create their own unique avatars. Built with Rails and integrated with modern AI tools, this application demonstrates best practices for AI-assisted development workflows.

## Features

- **Kid-Friendly Design**: Bright colors, playful language, and safe trait options
- **AI-Powered Generation**: Uses image models (e.g., Google Gemini 2.5) for consistent avatar creation
- **Mobile-First**: Responsive design optimized for mobile devices
- **Simple UI**: Minimal form with dropdowns/text fields and a single "Generate" button
- **AI Code Review**: Automated code review and suggestions via GitHub Actions with OpenAI Codex and Claude Code

## Tech Stack

- **Backend**: Ruby on Rails
- **Frontend**: Stimulus for interactivity
- **AI Integration**:
  - OpenAI Codex for code generation and automation
  - Claude Code for code review
  - Image generation model (e.g., Google Gemini 2.5) for avatar creation
- **CI/CD**: GitHub Actions for automated workflows

## Development Roadmap

### Week 1
- Set up Rails application
- Configure GitHub Actions
- Integrate Codex and Claude Code

### Week 2
- Implement UI components
- Set up API calls to image generation model

### Week 3
- Add kid-friendly design elements
- Mobile responsiveness testing

### Week 4
- Implement user authentication (Devise)
- Prepare for Spellbooks platform integration

## GitHub Actions Integration

This repository uses AI-powered automation tools:

- **Codex**: Triggered by `@codex` mentions in issues or `[codex]` prefix in issue titles
- **Claude Code**: Triggered by `@claude` mentions for code review and assistance

To use these tools, simply mention them in an issue or pull request comment.

## Success Metrics

- Avatar generation completes within 5 seconds
- Positive feedback from kid testers
- Seamless GitHub Actions automation
- Successful integration with Spellbooks platform

## Getting Started

### Prerequisites

- Ruby (version TBD)
- Rails (version TBD)
- Node.js 20+

### Installation

```bash
# Clone the repository
git clone https://github.com/procload/spellbooks-avatar.git
cd spellbooks-avatar

# Install dependencies
bundle install
npm install

# Set up the database
rails db:create db:migrate

# Start the development server
rails server
```

### Configuration

Set the following environment variables:

- `OPENAI_API_KEY`: For Codex integration
- `ANTHROPIC_API_KEY`: For Claude Code integration
- `IMAGE_MODEL_API_KEY`: For avatar generation

## Contributing

This project uses AI-assisted development workflows. To contribute:

1. Create an issue describing your proposed change
2. Mention `@codex` or `@claude` for AI assistance
3. Submit a pull request for review

## Future Plans

- User authentication with Devise
- Avatar storage and user profile integration
- Full integration with Spellbooks educational platform
- Expanded trait options and art styles

## Documentation

For detailed product requirements, see [docs/prd.md](docs/prd.md).

## License

[License TBD]

---

Built with ❤️ for the Spellbooks educational platform
