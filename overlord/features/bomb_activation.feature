Feature: Arm the bomb with an activation code
  In order to detonate the bomb
  But prevent other people from doing so
  As an evil genius
  I want to be able to arm the bomb with an activation code

Scenario: Arm the bomb
  Given I am on the home page
  When I enter a valid activation code
  Then the bomb should be armed

 # This scenario is commented out.
 # Feel free to uncomment it and modify
 # to suit your needs.
 #
 # Scenario: Enter a bad activation code
 #   Given I am on the home page
 #   When I enter the wrong activation code
 #   Then the bomb should not be armed
