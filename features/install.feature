Feature: Eboshi has a setup screen for new installations

  Scenario: User boots eboshi for the first time and sets up users
    Given I am on the homepage

    Then I should see "Installation"
    And I should see "Fill out the form below to create your user account."

    When I fill in the following:
      | Name                  | Micah           |
      | Email                 | micah@email.com |
      | Password              | secret          |
      | Password confirmation | secret          |

    And I press "Create account"
    Then I should see "Welcome, Micah!"
    And I should see "Congratulations!"
    And I should see "You have successfully installed Eboshi."

