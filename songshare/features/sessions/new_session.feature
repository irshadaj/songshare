@selenium
Feature: Signing in
  As a user
  I want to sign in
  In order to see my personal recommendations

  @record_top_tracks
  Scenario: Signing in with an invalid account
    Given I am on the home page
    When I fail to sign in to Spotify
    Then I see I used invalid credentials
    
  Scenario: Signing in with a new account
    Given I am on the home page
    When I sign in with my Spotify account
    Then I see a welcome message with my name
