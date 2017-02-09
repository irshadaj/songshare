Feature: Lock the safe with a combination
  As an evil genius
  I want to lock the safe
  In order to prevent prying eyes from seeing my documents

Scenario: Lock the safe
  Given I am on the home page
  When I lock the safe
  Then the safe should be locked

Scenario: Lock the safe with custom combination
  Given I am on the home page
  When I enter a valid custom combination
  And I lock the safe
  Then the safe should be locked

## This scenario is commented out.
## Feel free to uncomment it and modify
## to suit your needs.
#
# Scenario: Lock the safe with invalid combination
#   Given I am on the home page
#   When I enter an invalid custom combination
#   And I lock the safe
#   Then I see an invalid combination error
