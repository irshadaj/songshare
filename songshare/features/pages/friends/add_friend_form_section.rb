module Site
  class AddFriendFormSection < SitePrism::Section
    element :name_field, 'input#name'
    element :submit_button, '[type=submit]'
  end
end
