module Site
  class SearchFormSection < SitePrism::Section
    element :query_field, 'input#q'
    element :search_button, '[type=submit]'
  end
end
