@cucumber
Feature: Create email features

    @createEmail
    Scenario: create a new email
        Given I am on Inbox login page
        And I login as user1
        Then I see that login was successful
        And I create a new email
