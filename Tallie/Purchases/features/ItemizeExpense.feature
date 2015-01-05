@Tallie-Purchases

Feature: Tallie: Itemize Expense

  Scenario: Verify user can itemise expense
    Given I am on Purchases page
    When I add below itemizations to an expense:
    |item 1|{'reason_itemize' => 'any text', 'amount_itemize' => '10.00'}|
    |item 4|{'reason_itemize' => 'any text', 'amount_itemize' => '20.00'}|
  #  |item 2|{'reason_itemize' => 'any text', 'amount_itemize' => 'any amount'}|


  #  Then Expense tile is saved with edits
    Then I stopped