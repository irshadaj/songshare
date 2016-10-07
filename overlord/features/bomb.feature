Feature: The Bomb
  In order to achieve world domination
  As an evil genius
  I want to be able to arm the bomb

Scenario: Arm the bomb
  Given I am on the home page
  When I fill in "Code" with "1234"
  And I press "Activate"
  Then I should see "Bomb is active"

 # This scenario is commented out.
 # Feel free to uncomment it and modify
 # to suit your needs.
 #
 # Scenario: Disarm the bomb
 #   Given an active bomb
 #   And I am on the home page
 #   When I fill in "Code" with "0000"
 #   And I press "Deactivate"
 #   Then I should see "Bomb Inactive"
