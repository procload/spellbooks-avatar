# Eldritch UI 🔮

A magical ViewComponent-based design system for Ruby on Rails applications. Eldritch UI provides a comprehensive set of accessible, customizable UI components with a 3-tier design token system.

## Features

✨ **36 ViewComponents** - Button, Field, Select, Card, Modal, and more
🎨 **3-Tier Design Token System** - Semantic → Primitive → Foundation tokens
🎭 **10 Color Palettes** - Arcane Blue, Mystic Heather, Phoenix Red, and more
🖼️ **1,291 Heroicons** - Micro, mini, outline, and solid variants
⚡ **Stimulus Controllers** - Interactive behaviors built-in
♿ **Accessible** - WCAG 2.1 Level AA compliant with proper ARIA attributes
🎯 **Pure CSS** - No SCSS dependencies, works with Rails 8 Propshaft
📚 **Lookbook Ready** - Preview components in development

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eldritch_ui'
```

Or install from a local path during development:

```ruby
gem 'eldritch_ui', path: '~/eldritch-ui-export'
```

Then execute:

```bash
bundle install
```

## Setup

### 1. Import Stylesheets

Add to your `app/assets/stylesheets/application.css`:

```css
/*
 *= require eldritch_ui
 */
```

### 2. Register Stimulus Controllers

The engine automatically registers Stimulus controllers via importmap. Ensure your `app/javascript/application.js` includes:

```javascript
import "@hotwired/stimulus"
```

### 3. (Optional) Enable Lookbook Previews

If you use Lookbook for component previews, the previews are automatically available at `/lookbook` in development.

## Usage

### Basic Components

#### Button

```erb
<%= render EldritchUi::ButtonComponent.new(
  label: "Click Me",
  variant: :primary,
  size: :medium
) %>
```

#### Field with Input

```erb
<%= render EldritchUi::FieldComponent.new(
  label: "Email",
  status: :default
) do %>
  <%= render EldritchUi::TextInputComponent.new(
    name: "user[email]",
    type: :email,
    placeholder: "Enter your email"
  ) %>
<% end %>
```

#### Icon

```erb
<%= render EldritchUi::IconComponent.new(
  name: "sparkles",
  size: :medium,
  color: :primary
) %>
```

### Design Tokens

Eldritch UI uses a 3-tier design token system:

#### 1. Semantic Tokens (Preferred)
Use these first - they're purpose-driven:

```css
.my-component {
  background-color: var(--eld-semantic-color-primary);
  font-family: var(--eld-semantic-font-family-body);
  padding: var(--eld-semantic-space-component-padding-md);
  border-radius: var(--eld-semantic-border-radius-button);
}
```

#### 2. Primitive Tokens (Fallback)
Use when semantic tokens aren't available:

```css
.special-component {
  font-weight: var(--eld-primitive-font-weight-bold);
  border-radius: var(--eld-primitive-border-radius-full);
}
```

#### 3. Foundation Tokens (Internal Only)
Don't use these directly - they're for token definitions only.

### Color Palettes

Choose from 10 magical color palettes:

- `arcane-blue` - Deep mystical blues
- `mystic-heather` - Purple and violet tones
- `phoenix-red` - Warm oranges and reds
- `enchanted-green` - Natural greens
- `celestial-sky` - Light blues
- `parchment-neutral` - Warm neutrals
- `shadow-slate` - Cool grays
- `mystical-gold` - Golden yellows
- `ancient-oak` - Earthy browns
- `ancient-clay` - Terracotta tones

### Available Components

#### Form Components
- `ButtonComponent` - Interactive buttons with variants
- `CheckboxComponent` - Checkboxes with labels
- `RadioComponent` & `RadioGroupComponent` - Radio inputs
- `SelectComponent` - Styled select dropdowns
- `FieldComponent` - Form field wrapper
- `TextInputComponent` - Text inputs
- `TextareaComponent` - Textarea inputs
- `NumberInputComponent` - Number inputs
- `RangeInputComponent` - Range sliders
- `TokenInputComponent` - Tag/token input

#### Layout Components
- `CardComponent` - Content cards
- `TileComponent` - Interactive tiles
- `BannerComponent` - Alert banners
- `SidebarComponent` - Navigation sidebars
- `EmptyStateComponent` - Empty state displays

#### Display Components
- `IconComponent` - SVG icon renderer
- `PillComponent` - Pill badges
- `TagComponent` - Removable tags
- `ProgressBarComponent` - Progress indicators
- `ProgressIndicatorComponent` - Loading states
- `TooltipComponent` - Tooltips

#### Interactive Components
- `LoadingOverlayComponent` - Loading overlays
- `SegmentedControlComponent` - Segmented buttons

## Stimulus Controllers

Interactive components use Stimulus controllers:

- `button_controller.js` - Toggle button states
- `token_input_controller.js` - Tag input behavior
- `segmented_control_controller.js` - Segmented control
- `tile_controller.js` - Tile selection
- `tag_controller.js` - Tag removal
- `range_input_controller.js` - Range slider
- `loading_overlay_controller.js` - Loading states
- `progress_indicator_controller.js` - Progress animation

## Icons

1,291 Heroicons are included in 4 sizes:
- `micro` (16×16)
- `mini` (20×20)
- `outline` (24×24)
- `solid` (24×24)

Custom icons: `book`, `hat`, `scroll`

## App-Specific Components

⚠️ **Note:** Some components are specific to the original Spellbooks app and may need adaptation:

- `AssignStudentsFormComponent`
- `AssignmentCardComponent`
- `AssignmentImageComponent`
- `AssignmentItemComponent`
- `StudentAssignmentsContainerComponent`
- `StudentDetailComponent`
- `StudentSectionComponent`
- `GradeLevelPillsComponent`
- `GradeLevelSelectorComponent`
- `QuestionStepperComponent`
- `TemplateCardComponent`
- `InspirationCardComponent`

These serve as examples - you may want to remove or adapt them for your app.

## Testing

Run component tests:

```bash
bundle exec rake test
```

## Development

To experiment with this gem in a Rails app:

1. Clone or symlink to your app's vendor directory
2. Add to Gemfile: `gem 'eldritch_ui', path: 'vendor/eldritch_ui'`
3. Run `bundle install`
4. Access Lookbook previews at `/lookbook`

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

- Built with [ViewComponent](https://viewcomponent.org/)
- Icons from [Heroicons](https://heroicons.com/)
- Inspired by magical design systems everywhere ✨
