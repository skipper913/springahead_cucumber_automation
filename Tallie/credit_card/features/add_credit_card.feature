@Tallie-credit_card

Feature: Tallie: Add Credit Card

  Scenario: Verify user can add a credit card
    Given I am on Credit Card page
    When I add DagBank Credit Card
    Then I should see DagBank Credit Card added on the page
    And I should see the credit card account listed in the credit card list on Purchase page
    Then I stopped

