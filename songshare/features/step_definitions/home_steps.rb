def visit_home
  visit '/'
end

Given(/^I am on the home page$/) do
  visit_home
end

When(/^I visit the home page$/) do
  visit_home
end
