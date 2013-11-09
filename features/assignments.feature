Feature: Manage client-user associations
  Background:
    Given I am signed in as "Micah"

    And the following users exist:
      | name    | email               |
      | Michael | gubs@botandrose.com |
      | Kit     | kit@kit.com         |
    And the following clients exist:
      | name                  |
      | cheapbowlingballs.com |
      | bossanova             |
      | g2a                   |
      | fashions weekly       |
    And the user "Micah" has the following assignments:
      | client                |
      | cheapbowlingballs.com |
      | bossanova             |
    And the user "Michael" has the following assignments:
      | client                |
      | g2a                   |
      | bossanova             |
    And the user "Kit" has the following assignments:
      | client                |
      | fashions weekly       |
  
  Scenario: View assigned clients
    Given I am on the homepage
    Then I should see the following clients within the sidebar:
      | bossanova             |
      | cheapbowlingballs.com |
    
  Scenario: Collaborator list
    Given I am on the invoices page for "bossanova"
    Then I should see the following collaborators:
      | Micah   |
      | Michael |
    
  Scenario: User deletes anothers assignment
    Given I am on the invoices page for "bossanova"
    When I follow "delete" within the "Michael" collaborator
    Then I should see the following collaborators:
      | Micah   |
        
  Scenario: User deletes own assignment
    Given I am on the invoices page for "bossanova"
    When I follow "delete" within the "Micah" collaborator
    Then I should see the following clients:
      | cheapbowlingballs.com |
    
  Scenario: User sees a list of current associates on the invite collaborator page
    Given I am on the invoices page for "cheapbowlingballs.com"
    When I follow "Invite collaborator"
    Then I should see the following existing users:
      | Michael |
      | Other   |
    
  Scenario: User invites a known collaborator onto a project
    Given I am on the invoices page for "cheapbowlingballs.com"
    When I follow "Invite collaborator"
    And I choose "Michael"
    And I press "Invite"
    Then I should see the following collaborators:
      | Micah   |
      | Michael |

  Scenario: User invites a new collaborator onto a project
    Given I am on the invoices page for "cheapbowlingballs.com"
    When I follow "Invite collaborator"
    And I choose "Other"
    And I fill in "Email" with "kit@kit.com"
    And I press "Invite"
    Then I should see the following collaborators:
      | Micah   |
      | Kit     |

  Scenario: User invites a nonexistant collaborator onto a project
    Given I am on the invoices page for "cheapbowlingballs.com"
    When I follow "Invite collaborator"
    And I choose "Other"
    And I fill in "Email" with "bad@email.com"
    And I press "Invite"
    Then I should see "A user with that email address does not exist!"

