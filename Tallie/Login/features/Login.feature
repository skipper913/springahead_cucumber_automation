@Tallie-login

Feature: Verify Tallie Log in and Logout function
  Scenario: Verify a user can log in to Tallie with valid login credentials
    When I go to Login page
    And I log in with valid login credentials
    Then I see my name and enterprise displayed
    When I click Sign Out
    Then I should be on Login page
    Then I stopped
