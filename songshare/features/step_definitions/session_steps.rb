require 'pry'
def sign_out
  visit '/sign_out'
end

def sign_in
  visit '/users/auth/spotify'
  sleep(2)
  click_link_or_button 'Log in to Spotify'
  click_link_or_button 'Log in with Facebook'
  fill_in 'Email or Phone Number', :with => 'irshad.aj@gmail.com'
  fill_in 'Password', :with => 'REAL PASSWORD HERE'
  click_button 'Log In'
end

Given(/^I am signed in$/) do
  sleep(2)
end

Given(/^I am not signed in$/) do
  sign_out
end

When(/^I sign in with my Spotify account$/) do
  sign_in
end

When(/^I fail to sign in to Spotify$/) do
  visit '/sign_out'
  visit '/users/auth/spotify'
  click_link_or_button 'Log in to Spotify'
  click_link_or_button 'Log in with Facebook'
  fill_in 'Email or Phone Number', :with => 'irshad.aj@gmail.com'
  fill_in 'Password', :with => 'wrongpassword'
  click_button 'Log In'
end

When(/^I sign out$/) do
  sign_out
end

Then(/^I see a welcome message with my name$/) do
  expect(page).to have_text("Welcome, Irshad Ajmal Ahmed!")
end

Then(/^I see I used invalid credentials$/) do
  expect(page).not_to have_text('Welcome')
end

Then(/^I do not see the Sign Out link$/) do
  expect(Site.home.navbar).not_to have_sign_out
end

Then(/^I see I have signed out$/) do
  expect(page).to have_content('Signed out successfully')
end
