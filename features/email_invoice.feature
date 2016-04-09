Feature: User can email an invoice to the client's contact
  Background:
    Given the following users exist:
      | name  | email                |
      | Micah | micah@botandrose.com |
    And the following clients exist:
      | name      | email               |
      | bossanova | admin@bossanova.com |
    And the user "Micah" is assigned to "bossanova"
    And a time item for "bossanova"
    And I am signed in as "Micah"
    And I am on the invoices page for "bossanova"

  Scenario: User previews an invoice and emails it with some boilerplate
    When I follow "Create Invoice"
    And I press "Send"
    And I press "Send"
    Then I should see "Invoice sent to admin@bossanova.com"
    And "admin@bossanova.com" should receive an email

    When I open the email
    Then I should see the email delivered from "info@botandrose.com"
    And I should see "micah@botandrose.com" as the reply to address
    And I should see "Invoice #1" in the email subject
    And I should see an attachment named "invoice-1.pdf"
    And I should see the following in the email body:
      """
      Pay up!
      """

