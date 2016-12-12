Given(/^I am signed in$/) do
  @auth = OmniAuth.config.mock_auth[:spotify]
  Site.home.load
  Site.home.navbar.sign_in.click
  @user = User.find_by_uid(@auth[:uid])
end

When(/^I sign in with my Spotify account$/) do
  @auth = OmniAuth.config.mock_auth[:spotify]
  Site.home.navbar.sign_in.click
end

When(/^I fail to sign in to Spotify$/) do
  OmniAuth.config.mock_auth[:spotify] = :invalid_credentials
  Site.home.navbar.sign_in.click
end

When(/^I sign out$/) do
  Site.home.navbar.sign_out.click
end

Then(/^I see a welcome message with my name$/) do
  expect(page).to have_text("Welcome, #{@auth[:info][:name]}")
end

Then(/^I see I used invalid credentials$/) do
  expect(page).to have_text('invalid credentials')
end

Then(/^I do not see the Sign Out link$/) do
  expect(Site.home.navbar).not_to have_sign_out
end

Then(/^I see I have signed out$/) do
  expect(page).to have_content('Signed out successfully')
end
