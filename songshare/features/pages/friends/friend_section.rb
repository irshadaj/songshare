module Site
  class FriendSection < SitePrism::Section
    element :user_name, '.name'
    element :accept_link, 'a.accept-link'
    element :cancel_link, 'a.cancel-link'
    element :reject_link, 'a.reject-link'
    element :unfriend_link, 'a.unfriend-link'

    def has_name?(name)
      user_name.text.include?(name)
    end
  end
end
