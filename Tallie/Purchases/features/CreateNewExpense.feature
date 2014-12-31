@Tallie-Purchases

Feature: Tallie: Create New Expense
  Scenario: Verify user can create a new expense
    Given I am on Purchases page
    When I add a new expense by clicking New Expense button
    Then I see a new expense tile added on the page
    Then I stopped
