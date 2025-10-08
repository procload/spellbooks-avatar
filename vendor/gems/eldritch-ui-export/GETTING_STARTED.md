# Getting Started with Eldritch UI

## Quick Start Guide

Congratulations! You've successfully exported the Eldritch UI design system. Here's how to use it in another Rails application.

## What Was Exported

✅ **43 Ruby ViewComponents** (.rb files)
✅ **43 ERB Templates** (.html.erb files)
✅ **81 CSS Files** (design tokens, components, palettes)
✅ **11 Stimulus Controllers** (JavaScript)
✅ **1,291 SVG Icons** (Heroicons + 3 custom)
✅ **50 Test Files** (Minitest + Lookbook previews)
✅ **Rails Engine Configuration** (ready to use as gem)

📦 **Total Size:** ~6.5MB

## Installation Options

### Option 1: Local Gem (Recommended for Testing)

Add to your Rails app's `Gemfile`:

```ruby
gem 'eldritch_ui', path: '~/eldritch-ui-export'
```

Then run:

```bash
bundle install
```

### Option 2: Git Repository

1. Initialize git in the export directory:

```bash
cd ~/eldritch-ui-export
git init
git add .
git commit -m "Initial Eldritch UI export"
```

2. Push to GitHub/GitLab:

```bash
git remote add origin https://github.com/yourusername/eldritch-ui.git
git push -u origin main
```

3. Add to your app's `Gemfile`:

```ruby
gem 'eldritch_ui', git: 'https://github.com/yourusername/eldritch-ui.git'
```

### Option 3: RubyGems (For Production)

1. Update gemspec with your details in `~/eldritch-ui-export/eldritch_ui.gemspec`
2. Build the gem: `gem build eldritch_ui.gemspec`
3. Publish: `gem push eldritch_ui-0.1.0.gem`
4. Install: `gem install eldritch_ui`

## Configuration Steps

### 1. Import Stylesheets

In your `app/assets/stylesheets/application.css`:

```css
/*
 *= require eldritch_ui
 */
```

### 2. Verify Stimulus (Already Configured)

The engine auto-registers Stimulus controllers. Just ensure your `app/javascript/application.js` has:

```javascript
import "@hotwired/stimulus"
```

### 3. (Optional) Enable Lookbook

In development, visit `/lookbook` to preview components.

## First Component

Test the installation with a simple button:

```erb
<!-- app/views/home/index.html.erb -->
<%= render EldritchUi::ButtonComponent.new(
  label: "Hello Eldritch UI!",
  variant: :primary,
  size: :medium
) %>
```

## Clean Up App-Specific Components

Review `~/eldritch-ui-export/APP_SPECIFIC_COMPONENTS.md` to identify components you should remove or adapt.

**Quick cleanup example:**

```bash
# Remove assignment-related components
cd ~/eldritch-ui-export
rm app/components/eldritch_ui/assignment_*
rm app/components/eldritch_ui/student_*
rm app/javascript/controllers/eldritch_ui/assign_students_controller.js
```

## Next Steps

1. ✅ **Install in your Rails app** using one of the options above
2. ✅ **Test with a simple component** (button, icon, etc.)
3. ✅ **Review APP_SPECIFIC_COMPONENTS.md** and remove what you don't need
4. ✅ **Customize design tokens** in `app/assets/stylesheets/eldritch_ui/tokens/`
5. ✅ **Build your own domain components** using the patterns from examples

## Design Token Customization

Edit semantic tokens to match your brand:

```css
/* ~/eldritch-ui-export/app/assets/stylesheets/eldritch_ui/tokens/semantic.css */

:root {
  /* Primary color - change to your brand */
  --eld-semantic-color-primary: var(--eld-primitive-color-blue-600);

  /* Button styling */
  --eld-semantic-border-radius-button: var(--eld-primitive-border-radius-md);

  /* Typography */
  --eld-semantic-font-family-body: var(--eld-primitive-font-family-sans);
}
```

## Component Examples

### Form with Validation

```erb
<%= render EldritchUi::FieldComponent.new(
  label: "Email Address",
  status: @user.errors[:email].any? ? :error : :default,
  message: @user.errors[:email].first
) do %>
  <%= render EldritchUi::TextInputComponent.new(
    name: "user[email]",
    value: @user.email,
    type: :email,
    required: true
  ) %>
<% end %>
```

### Card Layout

```erb
<%= render EldritchUi::CardComponent.new(
  title: "Welcome",
  variant: :default
) do %>
  <p>This is a card with Eldritch UI styling!</p>
<% end %>
```

### Icon with Button

```erb
<%= render EldritchUi::ButtonComponent.new(
  variant: :primary
) do %>
  <%= render EldritchUi::IconComponent.new(name: "sparkles", size: :small) %>
  Click me!
<% end %>
```

## Troubleshooting

**Styles not loading?**
- Ensure `*= require eldritch_ui` is in `application.css`
- Restart Rails server after installing gem

**Stimulus controllers not working?**
- Check `app/javascript/application.js` imports Stimulus
- Verify importmap includes the engine: `bin/importmap json`

**Components not found?**
- Run `bundle install` after adding gem
- Restart Rails server

## File Structure

```
~/eldritch-ui-export/
├── app/
│   ├── components/eldritch_ui/     # ViewComponents
│   ├── assets/stylesheets/         # CSS & design tokens
│   ├── assets/svg/icons/           # 1,291 SVG icons
│   └── javascript/controllers/     # Stimulus controllers
├── lib/eldritch_ui/                # Engine configuration
├── test/components/                # Component tests
├── README.md                       # Main documentation
├── APP_SPECIFIC_COMPONENTS.md      # Components to review
├── GETTING_STARTED.md              # This file
├── CHANGELOG.md                    # Version history
└── eldritch_ui.gemspec             # Gem specification
```

## Support

- 📖 Full component docs: See `README.md`
- 🔍 App-specific cleanup: See `APP_SPECIFIC_COMPONENTS.md`
- 🎨 Design tokens: Explore `app/assets/stylesheets/eldritch_ui/tokens/`
- 🧪 Examples: Check `test/components/previews/` for Lookbook previews

## Success! 🎉

You now have a complete, portable design system ready to use in any Rails application. The original Spellbooks repo remains untouched.

Happy building! ✨
