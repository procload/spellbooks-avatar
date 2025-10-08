class EldritchUi::SidebarComponentPreview < ViewComponentTestCase::Preview
  # @label Default Sidebar (Teacher)
  # @display wrapper false
  def default
    setup_teacher_user
    render EldritchUi::SidebarComponent.new
  end

  # @label Admin Sidebar
  # @display wrapper false
  def admin_user
    setup_admin_user
    render EldritchUi::SidebarComponent.new
  end

  # @label Student Sidebar (No Students Link)
  # @display wrapper false
  def student_user
    setup_student_user
    render EldritchUi::SidebarComponent.new
  end

  # @label Custom Classes
  # @display wrapper false
  def with_custom_classes
    setup_teacher_user
    render EldritchUi::SidebarComponent.new(class: "custom-sidebar-class")
  end

  # @label Custom Attributes
  # @display wrapper false
  def with_custom_attributes
    setup_teacher_user
    render EldritchUi::SidebarComponent.new(
      id: "preview-sidebar",
      data: { testid: "sidebar-component" }
    )
  end

  private

  def setup_teacher_user
    Current.user = OpenStruct.new(
      first_name: "Teacher",
      last_name: "User",
      teacher?: true,
      admin?: false
    )
  end

  def setup_admin_user
    Current.user = OpenStruct.new(
      first_name: "Admin",
      last_name: "User",
      teacher?: false,
      admin?: true
    )
  end

  def setup_student_user
    Current.user = OpenStruct.new(
      first_name: "Student",
      last_name: "User",
      teacher?: false,
      admin?: false
    )
  end
end 