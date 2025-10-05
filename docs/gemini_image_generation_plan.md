# Gemini Image Generation Integration Plan

## Objectives
- Provide a configurable pipeline for generating avatar images using LLM-powered image APIs starting with Google Gemini.
- Keep prompts independent of providers so the same creative brief can be reused when switching APIs.
- Ensure the system is maintainable, observable, and resilient to provider or network failures.

## High-Level Architecture
1. **Prompt Authoring Layer**
   - Store prompt templates separately from provider-specific code (e.g., `config/prompts/avatar.yml`).
   - Load prompt definitions through `Rails.application.config_for(:prompts)` so the data benefits from Rails 8 encrypted config loading and avoids manual YAML parsing.
   - Templates accept dynamic parameters from the avatar form (e.g., age, style, background) and optional example image URLs.
   - Use ERB or Liquid to render prompts with structured slots to reduce formatting bugs.
2. **Provider Abstraction Layer**
   - Introduce a service interface (e.g., `ImageGeneration::Client`) with methods such as `generate_image(prompt:, config:)`.
   - Implement provider adapters under `app/services/image_generation/providers/` (starting with `GeminiProvider`).
   - Each provider handles API-specific payload construction, authentication, retries, and response parsing.
3. **Orchestration Service**
   - An `ImageGeneration::Service` composes the prompt, selects the provider via configuration, and invokes the provider adapter.
   - Enqueue expensive image generation calls via `ImageGeneration::Job` inheriting from `ApplicationJob`, executed by Solid Queue (Rails 8 default) to keep request threads responsive.
   - Centralize logging, error handling, caching, and safety checks (e.g., safe-search flags, content filters).
4. **Storage & Delivery**
   - Save resulting image URLs or binary blobs using Active Storage. Metadata should record prompt, provider, and parameters for auditing.

## Configuration Strategy
- Add `config/image_generation.yml` for environment-specific defaults (provider key, model version, retry limits, timeouts).
- Load the YAML through `Rails.application.config_for(:image_generation)` and expose strongly-typed settings via a `config.x.image_generation` struct to align with Rails 8 configuration patterns.
- Allow runtime override via `Rails.application.config.x.image_generation.provider` or ENV variables to swap providers without code changes.
- Support per-provider settings (e.g., Gemini `model: "models/imagegeneration"`, `aspect_ratio`, etc.).
- Include feature flag (e.g., Flipper) to toggle fallback providers or disable image generation if the primary API degrades.

## Prompt Template Design
- Store prompts in YAML with keys for context, system instructions, and user prompt sections.
- Example structure:
  ```yaml
  avatar:
    system: >-
      You are a creative assistant producing stylized avatar concepts.
    user: >-
      Create a portrait of a <%= hair_color %>-haired <%= species %> wearing <%= outfit %>...
    examples:
      - url: https://...
        description: Focus on neon lighting and cyberpunk accessories.
  ```
- The orchestration service loads the template, interpolates form data, and appends example image references.
- Keep provider-specific tokens (e.g., Gemini "grounding" formats) out of the prompt template. Instead, adapters translate the template into the provider payload.

## Google Gemini Integration Plan
1. **Credentials & SDK**
   - Use the official Gemini REST API via Faraday or the `google-ai-generativelanguage` gem once released/stable.
   - Store API keys in Rails credentials (`config/credentials.yml.enc`) keyed by environment.
2. **Provider Adapter Responsibilities**
   - Map the generic prompt to Gemini's `GenerateImagesRequest` payload.
   - Support configuration for model ID, safety settings, aspect ratio, and negative prompts (if available).
   - Handle retries with exponential backoff for `429` and transient errors (use `ActiveSupport::Notifications` for observability).
   - Parse the response to extract image data (base64 or URLs) and metadata (safety filters, prompt adjustments).
3. **Testing & Mocking**
   - Use VCR or WebMock fixtures for provider responses to keep tests deterministic.
   - Provide contract tests ensuring `ImageGeneration::Client` interface works regardless of provider.
   - Implement smoke rake task (`rake image_generation:smoke_test`) to validate credentials in staging.
   - Prefer Rails' built-in system and job test helpers (e.g., `perform_enqueued_jobs`) to verify Solid Queue orchestration without bespoke harnesses.
4. **Security & Compliance**
   - Enforce safe-search flags and log moderation status from Gemini.
   - Capture request IDs for tracing and rate-limit usage per user.

## Fallback & Provider Switching
- Implement a provider registry keyed by configuration (e.g., `ImageGeneration::Providers.build(name)`).
- Support multiple provider entries in the config to allow failover sequence (e.g., `[gemini, stability, dalle]`).
- Keep prompt templates provider-neutral; adapters translate to provider-specific fields such as negative prompts or example attachments.
- Include monitoring hooks to detect elevated error rates and switch providers automatically if needed.

## Observability & Maintenance
- Use structured logging with `prompt_id`, `provider`, `model`, and `request_duration`.
- Emit metrics via StatsD/Prometheus for request counts, latency, and error categories.
- Add an admin dashboard page to review recent generations, prompts, and moderation flags for QA.
- Document onboarding steps (credentials setup, config overrides) in `docs/image_generation_setup.md` (to be created during implementation).

## Rollout Strategy
1. Implement the abstraction and Gemini adapter behind feature flags.
2. Test end-to-end in staging with mocked prompts and sample avatars.
3. Gradually enable for a pilot group, monitor for latency and quality.
4. Collect feedback, adjust prompt templates, and iterate on fallback logic before full release.

## Next Steps
- [ ] Create prompt template YAMLs and rendering helper.
- [ ] Scaffold `ImageGeneration::Service` and `GeminiProvider` with configurable settings.
- [ ] Add automated tests (unit and integration) with mock responses.
- [ ] Implement logging, metrics, and admin visibility.
- [ ] Evaluate secondary provider support (Stability, OpenAI) for future-proofing.
