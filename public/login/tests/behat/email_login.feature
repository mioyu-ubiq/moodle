@core
Feature: Login using email
  Users should be able to access their account
  As a user
  I should be able to login using email

  Background:
    Given the following "users" exist:
      | username |password | firstname | lastname | email            |
      | testuser | test    | Test      | User     | user@example.com |

  Scenario Outline: A user van login using their email
    Given the following config values are set as admin:
      | authloginviaemail | <authloginviaemail> |
    And I am on site homepage
    When I follow "Log in"
    And I set the field "Username" to "<login>"
    And I set the field "Password" to "test"
    And I press "Log in"
    Then I should <expect> "You are logged in as" in the "page-footer" "region"

    Examples:
      | authloginviaemail | login            | expect  |
      | 0                 | testuser         | see     |
      | 0                 | user@example.com | not see |
      | 1                 | testuser         | see     |
      | 1                 | user@example.com | see     |
