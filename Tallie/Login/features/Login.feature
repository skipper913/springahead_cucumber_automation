@Tallie-login

Feature: Verify Tallie Log in function
  Scenario: Verify a user can log in to Tallie with valid login credentials
    Given I am on Login page
    When I log in with valid login credentials
    Then I see my name and enterprise displayed
    Then I stopped
