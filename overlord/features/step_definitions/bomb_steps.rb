# These step definitions are written using a library called Capybara.
#
# Capybara provides methods for interacting with your app as
# though it were a regular person clicking around in a web browser.
#
# The three methods you'll probably use most often are:
#
#     visit "/some/url"
#     click_on "Some link text or button text"
#     fill_in "A Field Name", with: "something or other"
#
# For more info check out https://github.com/jnicklas/capybara

Given(/^I am on the home page$/) do
  visit '/'
end

When(/^I enter a valid activation code$/) do
  fill_in "Activation Code", with: "9876"
end

Then(/^the bomb should be armed$/) do
  expect(page).to have_content("Bomb is armed")
end
