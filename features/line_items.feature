Feature: Manage line items to contruct invoices

  Background: User logs in
    Given today is "1983-06-19 16:20:00"

    Given I am signed in as "Micah"
    And a client exists with name: "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And I am on the invoices page for "bossanova"
  
  Scenario: User creates new time item    
    When I follow "New Time Item"
    And I select "1pm" as the "Start" time
    And I select "3pm" as the "End" time
    And I fill in "Rate" with "75"
    And I fill in "Notes" with "testing new time item"
    And I press "Create"
    Then I should see the following line items:
      | Micah | 06/19/83 13:00 15:00 | 2.00 | $75/hr | $150.00 | testing new time item |
    
# Scenario: User converts a time item into a flat fee
    When I follow "Edit"
    And I press "Convert to Flat fee"
    Then I should see "Time item converted to adjustment"
    And I should see the following line items:
      | Micah |06/19/83 | Flat Fee | $150.00 | testing new time item |

  Scenario: User creates new flat fee with date and user
    When I follow "New Flat Fee"
    And I select "1983-01-01" as the "Date" date
    And I fill in "Amount" with "300"
    And I fill in "Notes" with "testing new flat fee"
    And I press "Create"
    Then I should see the following line items:
      | Micah | 01/01/83 | Flat Fee | $300.00 | testing new flat fee |

# Scenario: User removes user and date from flat fee
    When I follow "Edit"
    And I check "No user"
    And I check "No date"
    And I press "Update"
    Then I should see the following line items:
      |  |  | Flat Fee | $300.00 | testing new flat fee |
    
  Scenario: User creates new flat fee without date and user
    When I follow "New Flat Fee"
    And I check "No user"
    And I select "1983-01-01" as the "Date" date
    And I check "No date"
    And I fill in "Amount" with "300"
    And I fill in "Notes" with "testing new flat fee"
    And I press "Create"
    Then I should see the following line items:
      |  |  | Flat Fee | $300.00 | testing new flat fee |
    
# Scenario: User adds user and date from flat fee
    When I follow "Edit"
    And I uncheck "No user"
    And I uncheck "No date"
    And I select "1983-01-01" as the "Date" date
    And I press "Update"
    Then I should see the following line items:
      | Micah | 01/01/83 | Flat Fee | $300.00 | testing new flat fee |
    
  Scenario: User merges two time items
    When I follow "New Time Item"
    # And I select "1pm" as the "Start" date and time
    And I select "1 pm" from "work_start_4i"
    # And I select "3pm" as the "End" date and time
    And I select "3 pm" from "work_finish_4i"
    And I fill in "Rate" with "75"
    And I fill in "Notes" with "new time item."
    And I press "Create"
    
    And I follow "New Time Item"
    # And I select "6pm" as the "Start" date and time
    And I select "6 pm" from "work_start_4i"
    # And I select "7pm" as the "End" date and time
    And I select "7 pm" from "work_finish_4i"
    And I fill in "Rate" with "75"
    And I fill in "Notes" with "and another!"
    And I press "Create"
    
    And I check all time items
    And I follow "Merge"
    Then I should see the following line items:
      | Micah | 06/19/83 18:20 21:20 | 3.00 | $75/hr | $225.00 | and another! new time item. |

