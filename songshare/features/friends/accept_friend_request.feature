@record_top_tracks
Feature: Accept friend request
  As a user
  I want to accept a friend request
  In order to share music with them

  Background:
    Given I am signed in
    And I have an incoming friend request
    And I am on the home page

  Scenario: Accept request
    When I accept their friend request
    Then I see I have no incoming friend requests

  Scenario: Request already accepted
    Given the friend request has been accepted
    When I accept their friend request
    Then I see I am already friends with them
