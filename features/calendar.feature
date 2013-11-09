Feature: Calendar that shows a summary of hours logged each day
  Background:
    Given I am signed in as "Micah"
    And a client exists with name: "bossanova"
    And the user "Micah" is assigned to "bossanova"

  Scenario: A user views a calendar
    Given today is "1983-06-19"
    And I worked 6 hours for "bossanova" today
    When I go to /calendar
    Then I should see "6 hours" within today
    And I should see the following calendar total:
      | 6 hours |
      | $300.00 |

  Scenario: A user views a calendar of a specific month
    When I go to /calendar/2009/11
    Then I should see "November"
    And I should not see "0 hours" within ".calendar"
    And I should not see "0.0" within ".calendar"

