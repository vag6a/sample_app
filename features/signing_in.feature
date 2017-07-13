Feature: Signing in

    Scenario: Unsuccessfull signing
        Given a user visits signing page
        When he submit invalid signin information
        Then he should see an error message

    Scenario: Successfull signing
        Given a user visits signing page
        And the user has an account
        And the user submits valid signin information
        Then he should see his profile page
        And he should see signout link
