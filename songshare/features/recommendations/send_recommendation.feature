@record_top_tracks
Feature: Recommend a song
  As a user
  I want to recommend my songs to others
  In order to help them expand their interests

  Background:
    Given I am signed in
    And I am on the song page

  Scenario: Recommending a song
    When I recommend the song to a friend
    Then the song should be added to friend's received recommendations
    And the song should be added to my sent recommendations

#  Scenario: Recommending a song without User ID
#    When the user field is empty
#    And I click on the recommend button
#    Then it should ask me to enter a user ID
