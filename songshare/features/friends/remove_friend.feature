@record_top_tracks
Feature: Remove friend
  As a user
  I want to unfriend a user
  In order to control who I share music with

  Background:
    Given I am signed in
    And I have friends
    And I am on the friends page

  Scenario: Removing friend
    When I unfriend a friend
    Then I see I have successfully unfriended them

  Scenario: Removing friend already removed
    Given my friend has been removed since I loaded the page
    When I unfriend a friend
    Then I see the friendship does not exist
