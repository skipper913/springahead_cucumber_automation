@Tallie-login

Feature: Tallie: Login and Logout Test
  Scenario: Verify login and logout function
    When I go to Login page
    And I log in with valid credentials
    Then I see my name and enterprise displayed
    When I click Sign Out
    Then I should be on Login page
    Then I stopped
