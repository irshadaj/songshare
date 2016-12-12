Feature: Searching songs
  As a user
  I want to search songs
  In order to find something to listen to

  @vcr
  Scenario: Search song title
    Given I am signed in
    And I am on the home page
    When I search for a song
    Then I see I am on the first page
    And I see a list of matching songs
    And I see players for each song

  Scenario: Searching song title without being signed in
    When I visit the home page
    Then I do not see the search bar
