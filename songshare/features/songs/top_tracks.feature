@record_top_tracks
Feature: Top tracks list
  As a user
  I want to see a list of my "top tracks"
  In order to see what songs are most recommended for me

  Scenario: Listing top tracks
    Given I am signed in
    When I visit the home page
    Then I see a list of my top tracks

  Scenario: No top tracks listed when not signed in
    When I visit the home page
    Then I do not see a list of my top tracks
