Feature: Sidebar should include a summary of user activity

  Scenario: A user views the month summary in the sidebar
    Given I am signed in as "Micah"
    And a client exists with name: "bossanova"
    And the user "Micah" is assigned to "bossanova"

    And today is "1983-02-02"
    And I worked 4 hours for "bossanova" today

    And today is "1983-06-19"
    And I worked 3 hours for "bossanova" today

    And today is "1983-06-20"
    And I worked 2 hours for "bossanova" today

    And today is "1983-06-26"
    And I worked 1 hours for "bossanova" today

    And today is "1983-06-20"
    And I am on the invoices page for "bossanova"

    Then I should see the following activity summary:
      | Year  | 10 hours | $500.00 |
      | Month | 6 hours  | $300.00 |
      | Week  | 5 hours  | $250.00 |
      | Day   | 2 hours  | $100.00 |

