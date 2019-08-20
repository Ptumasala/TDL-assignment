@cucumber
Feature: Signout features

    @signout
    Scenario: Log out from Inbox Web App
        Given I am on Inbox login page
        And I login as user1
        And I log out from Inbox App
