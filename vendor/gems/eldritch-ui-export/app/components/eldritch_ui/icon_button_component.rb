module EldritchUi
  class IconButtonComponent < ViewComponent::Base
    def initialize(icon_name:, title:, href: nil, onclick: nil, **html_attributes)
      @icon_name = icon_name
      @title = title
      @href = href
      @onclick = onclick
      @html_attributes = html_attributes
    end

    private

    attr_reader :icon_name, :title, :href, :onclick, :html_attributes

    def element_tag
      href.present? ? :a : :button
    end

    def element_attributes
      classes = [ "eld-icon-btn", html_attributes.delete(:class) ].compact.join(" ")
      attrs = { class: classes, title: title, aria: { label: title }, **html_attributes }
      attrs[:href] = href if href.present?
      attrs[:onclick] = onclick if onclick.present?
      attrs
    end
  end
end
