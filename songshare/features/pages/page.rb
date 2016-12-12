require_relative 'navbar_section'

module Site
  class Page < SitePrism::Page
    class << self
      include(Rails.application.routes.url_helpers)
    end

    section :navbar, NavbarSection, 'nav#page-navbar'
    element :page_notice, '.page-alert.alert-success'
    element :page_alert, '.page-alert.alert-danger'
    element :header, '.page-header'
  end
end
