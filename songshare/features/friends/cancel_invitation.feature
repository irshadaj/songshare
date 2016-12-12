@record_top_tracks
Feature: Cancel friend invitation
  As a user
  I want to cancel a friend invitation
  In order to correct my mistakes

  Background:
    Given I am signed in
    And I have an outgoing friend request
    And I am on the home page

  Scenario: Cancel invitation
    When I cancel my friend invitation
    Then I see I have no outgoing friend requests

  Scenario: Invitation already cancelled
    Given my friend invitation has been cancelled
    When I cancel my friend invitation
    Then I see the invitation does not exist
