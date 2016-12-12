@record_top_tracks
Feature: Listing friends
  As a user
  I want to see a list of my friends
  So I can send them recommendations

  Background:
    Given I am signed in

  Scenario: See my friends
    Given I have friends
    When I visit the home page
    Then I see my friends list
    And I see my friends' usernames

  Scenario: See my incoming friend requests
    Given I have an incoming friend request
    When I visit the home page
    Then I see the incoming friend request

  Scenario: See my outgoing friend requests
    Given I have an outgoing friend request
    When I visit the home page
    Then I see the outgoing friend request

  Scenario: See I am friendless
    When I visit the home page
    Then I see I have no friends

  Scenario: No incoming friend requests
    When I visit the home page
    Then I see I have no incoming friend requests

  Scenario: No outgoing friend requests
    When I visit the home page
    Then I see I have no outgoing friend requests
