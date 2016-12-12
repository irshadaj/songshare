@record_top_tracks
Feature: Add a friend
  As a user
  I want to add a friend
  In order to share music recommendations

  Background:
    Given I am signed in
    And I am on the home page

  Scenario: Add friend in the system
    When I add a friend
    Then I see the outgoing friend request

  Scenario: Attempt to add friend not in the system
    When I add an invalid friend
    Then I see an error: the user is not in the system
