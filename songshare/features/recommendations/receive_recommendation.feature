@record_top_tracks
Feature: Receive song recommendations
  As a user
  I want to see what songs have been recommended to me
  In order to decide what to listen to

  Background:
    Given I am signed in
    And I am on the recommendations page

  Scenario: Receive recommendation
    When a friend recommends a song to me
    Then the song should be added to my received recommendations

  Scenario: Like recommendation
    Given I have existing recommendations
    When I like a recommendation
    Then the song should be liked
