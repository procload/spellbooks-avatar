# frozen_string_literal: true

# @label Empty State
class EldritchUi::EmptyStateComponentPreview < ViewComponent::Preview
    # @label Default
    def default
      render EldritchUi::EmptyStateComponent.new(
        title: "No Results Found"
      )
    end

    # @label With Description
    def with_description
      render EldritchUi::EmptyStateComponent.new(
        title: "No Assignments Found",
        description: "Try adjusting your search criteria or create a new assignment to get started."
      )
    end

    # @label With Icon
    def with_icon
      render EldritchUi::EmptyStateComponent.new(
        title: "Empty Folder",
        description: "This folder doesn't contain any files yet.",
        icon_name: "folder"
      )
    end

    # @label With Search Icon
    def with_search_icon
      render EldritchUi::EmptyStateComponent.new(
        title: "No Search Results",
        description: "We couldn't find anything matching your search. Try different keywords.",
        icon_name: "search"
      )
    end

    # @label With Academic Icon
    def with_academic_icon
      render EldritchUi::EmptyStateComponent.new(
        title: "No Assignments Yet",
        description: "Create your first assignment to begin engaging your students.",
        icon_name: "academic-cap"
      )
    end

    # @label Small Icon Size
    def small_icon_size
      render EldritchUi::EmptyStateComponent.new(
        title: "Small Icon Example",
        description: "This example shows a small icon size.",
        icon_name: "light-bulb",
        icon_size: :small
      )
    end

    # @label Large Icon Size
    def large_icon_size
      render EldritchUi::EmptyStateComponent.new(
        title: "Large Icon Example",
        description: "This example shows a large icon size.",
        icon_name: "star",
        icon_size: :large
      )
    end

    # @label Large Size Variant
    def large_size_variant
      render EldritchUi::EmptyStateComponent.new(
        title: "Large Empty State",
        description: "This is a large size variant with increased spacing and typography.",
        icon_name: "plus",
        size: :large
      )
    end

    # @label With Single Button Action
    def with_single_button_action
      component = EldritchUi::EmptyStateComponent.new(
        title: "No Data Available",
        description: "Get started by creating your first item."
      )
      
      component.with_primary_action_button(
        label: "Create New Item",
        variant: :primary
      )

      render component
    end

    # @label With Single Link Action
    def with_single_link_action
      component = EldritchUi::EmptyStateComponent.new(
        title: "No Templates Found",
        description: "Browse our collection of pre-built templates."
      )
      
      component.with_primary_action_link(
        href: "/templates",
        label: "Browse Templates"
      )

      render component
    end

    # @label With Multiple Actions
    def with_multiple_actions
      component = EldritchUi::EmptyStateComponent.new(
        title: "No Assignments Created",
        description: "Start by creating a new assignment or browse from our template library.",
        icon_name: "academic-cap"
      )
      
      component.with_secondary_action_button(
        label: "Create Assignment",
        variant: :primary
      )
      
      component.with_secondary_action_button(
        label: "Browse Templates",
        variant: :secondary
      )

      render component
    end

    # @label With Mixed Action Types
    def with_mixed_action_types
      component = EldritchUi::EmptyStateComponent.new(
        title: "Get Started",
        description: "Choose how you'd like to begin your journey.",
        icon_name: "sparkles"
      )
      
      component.with_secondary_action_button(
        label: "Create New",
        variant: :primary
      )
      
      component.with_secondary_action_link(
        href: "/help",
        label: "Need Help?"
      )

      render component
    end

    # @label New Teacher Assignment Empty State
    def new_teacher_assignments
      component = EldritchUi::EmptyStateComponent.new(
        title: "Start Your Teaching Journey",
        description: "Create your first assignment to begin engaging your students.",
        icon_name: "academic-cap",
        size: :large
      )
      
      component.with_primary_action_button(
        label: "Create New Assignment",
        variant: :primary
      )

      render component
    end

    # @label Filtered Results Empty State
    def filtered_results
      component = EldritchUi::EmptyStateComponent.new(
        title: "No Assignments Found",
        description: "We couldn't find any assignments matching your current filters.",
        icon_name: "search"
      )
      
      component.with_secondary_action_button(
        label: "Clear Filters",
        variant: :secondary
      )
      
      component.with_secondary_action_button(
        label: "Create New Assignment",
        variant: :primary
      )

      render component
    end

    # @label Student View Empty State
    def student_view
      render EldritchUi::EmptyStateComponent.new(
        title: "No Assignments Yet",
        description: "Your teacher will assign work to you soon. Check back later!",
        icon_name: "clock"
      )
    end

    # @label Visitor Empty State
    def visitor_state
      component = EldritchUi::EmptyStateComponent.new(
        title: "Welcome to Spellbooks",
        description: "Please sign in to view your assignments and get started.",
        icon_name: "login"
      )
      
      component.with_primary_action_button(
        label: "Sign In",
        variant: :primary
      )

      render component
    end

    # @label Subject-Specific Empty State
    def subject_specific
      component = EldritchUi::EmptyStateComponent.new(
        title: "No Math Assignments Found",
        description: "Get started by creating your first mathematics assignment.",
        icon_name: "calculator"
      )
      
      component.with_primary_action_button(
        label: "Create Math Assignment",
        variant: :primary
      )

      render component
    end

    # @label Error State
    def error_state
      component = EldritchUi::EmptyStateComponent.new(
        title: "Something Went Wrong",
        description: "We encountered an error while loading your content. Please try again.",
        icon_name: "exclamation-triangle"
      )
      
      component.with_primary_action_button(
        label: "Try Again",
        variant: :primary
      )

      render component
    end

    # @label Loading State
    def loading_state
      component = EldritchUi::EmptyStateComponent.new(
        title: "Loading Your Content",
        description: "Please wait while we fetch your assignments.",
        icon_name: "loading"
      )

      render component
    end

    # @label With Custom Content
    def with_custom_content
      component = EldritchUi::EmptyStateComponent.new(
        title: "Advanced Features",
        description: "Explore additional options and customizations."
      )
      
      component.with_custom_content do
        '<div class="space-y-4 text-center">
          <div class="text-lg">📚 Browse Templates</div>
          <div class="text-lg">✨ Quick Start Guide</div>
          <div class="text-lg">🎯 Best Practices</div>
        </div>'.html_safe
      end

      render component
    end

    # @label Minimal Example
    def minimal_example
      render EldritchUi::EmptyStateComponent.new(
        title: "Simple Empty State"
      )
    end

    # @label Complete Example
    def complete_example
      component = EldritchUi::EmptyStateComponent.new(
        title: "Complete Empty State Example",
        description: "This example demonstrates all available features of the EmptyStateComponent including icons, custom sizing, and multiple action types.",
        icon_name: "sparkles",
        icon_size: :large,
        size: :large,
        class: "featured-empty-state border-2 border-dashed border-gray-300",
        id: "complete-example"
      )
      
      component.with_primary_action_button(
        label: "Primary Action",
        variant: :primary
      )
      
      component.with_secondary_action_button(
        label: "Secondary Action",
        variant: :secondary
      )
      
      component.with_secondary_action_link(
        href: "/learn-more",
        label: "Learn More"
      )

      render component
    end

    # @label Long Text Example
    def long_text_example
      render EldritchUi::EmptyStateComponent.new(
        title: "This is a Very Long Title That Might Wrap to Multiple Lines on Smaller Screens",
        description: "This is an example with a very long description that demonstrates how the component handles extensive text content. The description should wrap properly and maintain good readability across different screen sizes while preserving the visual hierarchy and spacing of the component."
      )
    end

    # @label Mobile Responsive Example
    def mobile_responsive
      component = EldritchUi::EmptyStateComponent.new(
        title: "Mobile Responsive",
        description: "This component adapts to different screen sizes automatically.",
        icon_name: "device-phone-mobile"
      )
      
      component.with_secondary_action_button(
        label: "Mobile Action",
        variant: :primary
      )
      
      component.with_secondary_action_button(
        label: "Secondary",
        variant: :secondary
      )

      render component
    end
  end 