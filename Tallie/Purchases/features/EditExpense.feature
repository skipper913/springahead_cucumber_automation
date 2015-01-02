@Tallie-Purchases

Feature: Tallie: Edit Expense

  Scenario: Verify user can edit expense
    Given I am on Purchases page
    When I edit a expense as below:
      | merchant | any text |
      | category | Events   |
      | reason   | any text |
      | amount   | any text |

    Then Expense tile is saved with edits
    Then I stopped
