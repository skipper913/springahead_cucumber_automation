@Tallie-Purchases

Feature: Tallie: Create New Expense

  Scenario: Verify user can create a new expense
    Given I am on Purchases page
    When I add a new expense with below data by clicking New Expense button:
      | merchant | Cucumber Auto        |
      | category | Airfare              |
      | reason   | Auto-generate reason |
      | amount   | Auto-generate amount |

    Then the new expense tile is added on the page
    Then I stopped
