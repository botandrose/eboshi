Feature: Should be able to see the user breakdown for each invoice

  Scenario: User views breakdown
    Given I am signed in as "Micah"
    And a user exists with name: "Michael"
    And a user exists with name: "Kit"
    And a client exists with name: "bossanova"
    And the client "bossanova" has the following assignments:
      | user    |
      | Micah   |
      | Michael |
      | Kit     |
    And 3 unbilled works exist with client: "Bossanova", user: "Micah"
    And 2 unbilled works exist with client: "Bossanova", user: "Michael"
    And 1 unbilled work exists with client: "Bossanova", user: "Kit"
    And I am on the invoices page for "bossanova"

    Then I should see the following invoice breakdown:
      | Kit     | 1.00 | $50.00  |
      | Micah   | 3.00 | $150.00 | 
      | Michael | 2.00 | $100.00 |

