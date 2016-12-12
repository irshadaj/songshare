require_relative 'search_form_section'

module Site
  class NavbarSection < SitePrism::Section
    section :search_form, SearchFormSection, 'form.search-form'
    element :brand_link, 'a.navbar-brand'
    element :sign_in, 'a.sign_in'
    element :sign_out, 'a.sign_out'
  end
end
