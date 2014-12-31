

Feature: Create a Expense

  Scenario: Create a expense

    #Given I am logged in to Tallie
    Given I go to Purchases page
    And I have a new expense tile opened -- expense
  And I submit Free Trial form
  #And I have a new expense tile opened
   # When I enter below data in the expense tile
#      | merchant name | Auto Expense       |
#      | categpry      | Airfare            |
#      | Reasons       | Testing automation |
#      | amount        | 100                |
   # Then I see a new expense added with data: