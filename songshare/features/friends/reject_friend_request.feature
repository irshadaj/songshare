@record_top_tracks
Feature: Reject friend request
  As a user
  I want to reject a friend request
  In order to control who I share music with

  Background:
    Given I am signed in
    And I have an incoming friend request
    And I am on the friends page

  Scenario: Reject request
    When I reject their friend request
    Then I see I have no incoming friend requests

  Scenario: Request already rejected
    Given the friend request has been rejected
    When I reject their friend request
    Then I see the friend request does not exist
