def add_friend(name)
  form = Site.home.friends_list.add_friend_form
  form.name_field.set(name)
  form.submit_button.click
end

Given(/^I have friends$/) do
  @friends = create_list(:user, 3)

  @friends.each do |user|
    create(:friendship, user: @user, friend: user)
    create(:friendship, user: user, friend: @user)
  end
end

Given("I am on the friends page") do
  visit '/friends'
end

Given(/^I have an incoming friend request$/) do
  @incoming = create(:user)
  create(:friendship, user: @incoming, friend: @user)
end

Given(/^I have an outgoing friend request$/) do
  @outgoing = create(:user)
  create(:friendship, user: @user, friend: @outgoing)
end

Given(/^my friend has been removed since I loaded the page$/) do
  Friendship.delete_all
end

Given(/^my friend invitation has been cancelled$/) do
  Friendship.find_by(user: @user, friend: @outgoing).delete
end

Given(/^the friend request has been accepted$/) do
  create(:friendship, user: @user, friend: @incoming)
end

Given(/^the friend request has been rejected$/) do
  Friendship.find_by(user: @incoming, friend: @user).delete
end

When("I visit the friends page") do
  visit '/friends'
end

When(/^I add a friend$/) do
  @outgoing = create(:user)
  add_friend(@outgoing.uid)
end

When(/^I add an invalid friend$/) do
  add_friend('Invalid')
end

When(/^I unfriend a friend$/) do
  Site.home.friends_list.friends.first.unfriend_link.click
end

When(/^I cancel my friend invitation$/) do
  Site.home.friends_list.outgoing_requests.first.cancel_link.click
end

When(/^I (accept|reject) their friend request$/) do |link_type|
  request = Site.home.friends_list.incoming_requests.first
  request.send("#{link_type}_link").click
end

Then(/^I see my friends list$/) do
  expect(page).to have_friends_list
end

Then(/^I do not see the friends list$/) do
  expect(Site.home).not_to have_friends_list
end

Then(/^I see I have no friends$/) do
  expect(Site.home.friends_list).not_to have_friends
end

Then(/^I see my friends' usernames$/) do
  expect(Site.home.friends_list).to have_friends(count: @friends.length)
  @friends.each { |friend| expect(Site.home.friends_list.friends).to include(have_name(friend.uid)) }
end

Then(/^I see the incoming friend request$/) do
  expect(Site.home.friends_list).to have_incoming_requests(count: 1)
  expect(Site.home.friends_list.incoming_requests.first).to have_content(@incoming.uid)
end

Then(/^I see I have no incoming friend requests$/) do
  expect(Site.home.friends_list).not_to have_incoming_requests
end

Then(/^I see the outgoing friend request$/) do
  expect(Site.home.friends_list).to have_outgoing_requests(count: 1)
  expect(Site.home.friends_list.outgoing_requests.first).to have_content(@outgoing.uid)
end

Then(/^I see I have no outgoing friend requests$/) do
  expect(Site.home.friends_list).not_to have_outgoing_requests
end

Then(/^I see an error: the user is not in the system$/) do
  expect(Site.home.page_alert).to have_content("'Invalid' is not registered with Songshare")
end

Then(/^I see I have successfully unfriended them$/) do
  expect(Site.home.page_notice).to have_content('Successfully removed friend')
end

Then(/^I see the (?:friendship|invitation|friend request) does not exist$/) do
  expect(Site.home.page_alert).to have_content('You are not friends with this person')
end

Then(/^I see I am already friends with them$/) do
  expect(Site.home.page_alert.text).to match(/Friend .* already added/)
end
