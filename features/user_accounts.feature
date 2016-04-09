Feature: User accounts

  Scenario: User logs out
    Given I am signed in as "Micah"
    When I follow "Logout"
    Then I should see "Logout successful"
    
  Scenario: Add user
    Given I am signed in as "Micah"
    When I follow "Add Client"
    And I fill in "Project Name" with "Domaine Selections"
    And I press "Create"
    Then I should see the following clients:
      | Domaine Selections |
    
  Scenario: User cancels my account
    Given I am signed in as "Micah"
    When I follow "My Account"
    And I follow "cancel"
    Then I should see "All Clients"

  Scenario: Admin cancels my account
    Given I am signed in as an Admin
    When I follow "My Account"
    And I follow "cancel"
    Then I should see "All Users"

