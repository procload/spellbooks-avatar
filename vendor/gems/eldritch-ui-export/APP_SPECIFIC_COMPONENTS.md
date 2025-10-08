# App-Specific Components

This document lists components that were extracted from the Spellbooks application and may contain domain-specific logic. You should review these components and decide whether to:

1. **Keep as examples** - Use them as reference implementations
2. **Adapt for your app** - Modify to fit your domain model
3. **Remove** - Delete if not needed

## Components with Spellbooks-Specific Logic

### Assignment-Related Components

#### `AssignStudentsFormComponent`
- **Purpose:** Form for assigning students to assignments
- **Dependencies:** Expects `assignment` and `students` objects with specific attributes
- **Location:** `app/components/eldritch_ui/assign_students_form_component.rb`
- **Recommendation:** Adapt or remove - contains Spellbooks assignment logic

#### `AssignmentCardComponent`
- **Purpose:** Display card for homework assignments
- **Dependencies:** Expects `assignment` object with fields like `title`, `subject`, `grade_level`
- **Location:** `app/components/eldritch_ui/assignment_card_component.rb`
- **Recommendation:** Use as example pattern for your domain cards

#### `AssignmentImageComponent`
- **Purpose:** Display assignment cover images
- **Dependencies:** Expects `assignment` object with image attachments
- **Location:** `app/components/eldritch_ui/assignment_image_component.rb`
- **Recommendation:** Adapt for your image display needs

#### `AssignmentItemComponent`
- **Purpose:** List item for assignments
- **Dependencies:** Expects `assignment` object
- **Location:** `app/components/eldritch_ui/assignment_item_component.rb`
- **Recommendation:** Use as list item pattern example

#### `ReadingPassageComponent`
- **Purpose:** Display reading passage content
- **Dependencies:** Expects `passage` text and optional `image_url`
- **Location:** `app/components/eldritch_ui/reading_passage_component.rb`
- **Recommendation:** Could be generic - review for reusability

### Student-Related Components

#### `StudentAssignmentsContainerComponent`
- **Purpose:** Container for student assignment views
- **Dependencies:** Expects student and assignment relationships
- **Location:** `app/components/eldritch_ui/student_assignments_container_component.rb`
- **Recommendation:** Remove unless you have student management

#### `StudentDetailComponent`
- **Purpose:** Display student information
- **Dependencies:** Expects `student` object
- **Location:** `app/components/eldritch_ui/student_detail_component.rb`
- **Recommendation:** Remove unless you have student management

#### `StudentSectionComponent`
- **Purpose:** Student information section
- **Dependencies:** Expects `student` object
- **Location:** `app/components/eldritch_ui/student_section_component.rb`
- **Recommendation:** Remove unless you have student management

### Education-Specific Components

#### `GradeLevelPillsComponent`
- **Purpose:** Pills for selecting grade levels (K-12)
- **Dependencies:** Hard-coded grade levels
- **Location:** `app/components/eldritch_ui/grade_level_pills_component.rb`
- **Recommendation:** Keep if you need grade level selection, otherwise remove

#### `GradeLevelSelectorComponent`
- **Purpose:** Dropdown for selecting grade levels
- **Dependencies:** Hard-coded grade levels
- **Location:** `app/components/eldritch_ui/grade_level_selector_component.rb`
- **Recommendation:** Keep if you need grade level selection, otherwise remove

#### `SubjectDisplayComponent` (if exists)
- **Purpose:** Display academic subjects
- **Dependencies:** Subject enums
- **Recommendation:** Remove if not education-focused

#### `QuestionStepperComponent`
- **Purpose:** Step through multiple-choice questions
- **Dependencies:** Expects `questions` collection
- **Location:** `app/components/eldritch_ui/question_stepper_component.rb`
- **Recommendation:** Could be adapted for multi-step forms

### Template/Content Components

#### `TemplateCardComponent`
- **Purpose:** Display assignment templates
- **Dependencies:** Expects `template` object
- **Location:** `app/components/eldritch_ui/template_card_component.rb`
- **Recommendation:** Use as card pattern example

#### `InspirationCardComponent`
- **Purpose:** Display inspiration/suggestion cards
- **Dependencies:** Expects `inspiration` or similar object
- **Location:** `app/components/eldritch_ui/inspiration_card_component.rb`
- **Recommendation:** Adapt for your content cards

#### `PopularTagsComponent`
- **Purpose:** Display popular/trending tags
- **Dependencies:** Expects tags collection
- **Location:** `app/components/eldritch_ui/popular_tags_component.rb`
- **Recommendation:** Keep if you have tagging

### Quiz/Assessment Components

#### `AnswerChoiceComponent`
- **Purpose:** Display multiple-choice answer options
- **Dependencies:** Expects answer choice data
- **Location:** `app/components/eldritch_ui/answer_choice_component.rb`
- **Recommendation:** Remove unless you have quizzes/assessments

#### `AnswerEditComponent` (if exists)
- **Purpose:** Edit answer choices
- **Recommendation:** Remove unless you have quiz authoring

## Generic/Reusable Components

These components are likely reusable across any Rails app:

✅ **Keep These:**
- `ButtonComponent`
- `CheckboxComponent`
- `RadioComponent`, `RadioGroupComponent`
- `SelectComponent`
- `FieldComponent`
- `TextInputComponent`
- `TextareaComponent`
- `NumberInputComponent`
- `RangeInputComponent`
- `TokenInputComponent`
- `IconComponent`
- `PillComponent`
- `TagComponent`
- `TileComponent`
- `BannerComponent`
- `SidebarComponent`
- `EmptyStateComponent`
- `LoadingOverlayComponent`
- `ProgressBarComponent`
- `ProgressIndicatorComponent`
- `TooltipComponent`
- `SegmentedControlComponent`
- `HandDrawnBorderComponent`
- `ScrollFieldComponent`
- `InlineHeadingEditComponent`
- `IconButtonComponent`

## Stimulus Controllers to Review

### App-Specific Controllers
- `assign_students_controller.js` - Assignment-specific logic
- `answer_choice_controller.js` - Quiz answer logic

### Generic Controllers (Keep)
- `button_controller.js`
- `token_input_controller.js`
- `segmented_control_controller.js`
- `tile_controller.js`
- `tag_controller.js`
- `range_input_controller.js`
- `loading_overlay_controller.js`
- `progress_indicator_controller.js`
- `mobile_menu_controller.js`

## Action Items

1. **Review each app-specific component** listed above
2. **Remove components** you don't need: `rm ~/eldritch-ui-export/app/components/eldritch_ui/assignment_card_component.*`
3. **Update tests** after removing components
4. **Update gemspec** to exclude removed files if needed
5. **Create your own domain components** using the patterns from these examples

## Extraction Guide

To create your own domain-specific components:

1. Copy the structure from similar Spellbooks components
2. Follow the ViewComponent patterns (initializer params, templates, CSS)
3. Use semantic design tokens for styling
4. Add proper ARIA attributes for accessibility
5. Create Lookbook previews for documentation
6. Write component tests
