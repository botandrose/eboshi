Feature: Invoices should include a users optional customized logo and signature

  Scenario: User updates account and views an invoice
    Given I am signed in as "Micah"
    And a client exists with name: "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And an invoice exists for "bossanova"
    And I am on /
    When I follow "My Account"
    And I fill in "Business name" with "Bot & Rose"
    And I fill in "Business email" with "info@botandrose.com"
    And I fill in "Address" with "625 NW Everett St #346"
    And I fill in "user_address2" with ""
    And I fill in "City" with "Portland"
    And I fill in "State" with "Oregon"
    And I fill in "Zipcode" with "97209"
    And I upload a logo image
    And I upload a signature
    And I press "Update"
    Then I should see "Account updated"

    When I go to the first invoice for "bossanova"
    And I should see "info@botandrose.com"
    And I should see "625 NW Everett St #346"
    And I should see "Portland, Oregon 97209"
    Then the logo should be an image
    And the signature should be an image

  Scenario: User with no logo or signature views an invoice
    Given I am signed in as "Micah"
    And a client exists with name: "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And an invoice exists for "bossanova"
    When I go to the first invoice for "bossanova"
    Then the logo should say "Micah"
    And the signature should say "Micah"

