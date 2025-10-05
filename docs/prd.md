# Product Requirements Document (PRD) – Spellbooks Avatar Generator Mini-App

## 1. Overview

The Spellbooks Avatar Generator is a simple web application that allows users, especially kids, to create personalized avatars for the Spellbooks educational app. It will use a Rails backend, integrate OpenAI Codex and Claude Code for automated setup and code review via GitHub Actions, and leverage an image model (such as Google Gemini 2.5) to generate avatars.

## 2. Goals & Objectives

- Provide a fun, kid-friendly tool for generating avatars.
- Learn to set up Codex and Claude Code in GitHub Actions for code reviews and automation.
- Use image models to generate avatars with a consistent art style.
- Build a scalable, easy-to-integrate app for the Spellbooks platform.

## 3. Features

- **UI Simplicity:** Minimal, mobile-friendly form with dropdowns or text fields for avatar traits and a single “Generate” button.
- **Image Generation:** Generate avatars using an image model (e.g., Gemini) from predefined styles and traits.
- **Kid-Friendly Design:** Bright colors, playful language, safe trait options, and no user-generated content.
- **GitHub Actions Integration:** Codex and Claude Code will review, suggest, and automate code improvements.
- **Future Integration:** User authentication with Devise to save avatars and link them to Spellbooks accounts.

## 4. Technical Requirements

- Rails app with a lightweight frontend using Stimulus for interactivity.
- Integration with OpenAI Codex and Claude Code via GitHub Actions for continuous integration.
- API calls to an image generation model for avatar creation.
- Responsive design for mobile usability.

## 5. Timeline

- **Week 1:** Set up Rails app, GitHub Actions, and Codex/Claude integration.
- **Week 2:** Implement the UI and API calls to the image model.
- **Week 3:** Add kid-friendly design elements and test on mobile.
- **Week 4:** Implement optional user authentication and prepare for Spellbooks integration.

## 6. Success Metrics

- Avatars generated successfully within 5 seconds.
- Positive feedback from initial kid testers.
- Seamless integration with GitHub Actions and automation tools.
