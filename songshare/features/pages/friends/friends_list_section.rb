require_relative 'add_friend_form_section'
require_relative 'friend_section'

module Site
  class FriendsListSection < SitePrism::Section
    section :add_friend_form, AddFriendFormSection, 'form'
    sections :friends, FriendSection, 'ul.my-friends li'
    sections :incoming_requests, FriendSection, 'ul.incoming-requests li'
    sections :outgoing_requests, FriendSection, 'ul.outgoing-requests li'
  end
end
