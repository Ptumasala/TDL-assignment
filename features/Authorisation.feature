@cucumber
Feature: Authorisation features

    @signin
    Scenario: Sign in Inbox Web App
        Given I am on Inbox login page
        And I login as user1
        Then I see that login was successful
