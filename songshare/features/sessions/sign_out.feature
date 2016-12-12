Feature: Signing out
  As a user
  I want to sign out of my account
  In order to prevent unauthorized access

  @record_top_tracks
  Scenario: Sign out
    Given I am signed in
    And I am on the home page
    When I sign out
    Then I see I have signed out

  Scenario: Not logged in
    When I visit the home page
    Then I do not see the Sign Out link
