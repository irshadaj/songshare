Feature: Home page without a session
  As a user
  I should not see any account information when not signed in
  In order to protect the account information of others

  Scenario: Visiting the home page without a session
    When I visit the home page
    Then I do not see the friends list
    And I do not see a list of my top tracks
