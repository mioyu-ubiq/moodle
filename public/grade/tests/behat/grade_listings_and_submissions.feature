@core @core_grades
Feature: Verify listings and grading submission as a teacher 
  
 Background:
    Given the following "users" exist:
      | username | firstname | lastname | email           |
      | user1    | User      | One      | one@example.com |
      | user2    | User      | Two      | two@example.com |
      | teach1   | Teach     | One      | t1@example.com  |
    And the following "courses" exist:
      | shortname | fullname |
      | C1        | Course 1 |
    And the following "course enrolments" exist:
      | user   | course | role           |
      | user1  | C1     | student        |
      | user2  | C1     | student        |
      | teach1 | C1     | editingteacher |
    And the following "activities" exist:
      | activity | name    | course | advancedgradingmethod_submissions | assignsubmission_onlinetext_enabled |
      | assign   | Assign1 | C1     | guide                             | 1                                   |
    And I am on the "Course 1" course page logged in as teach1
    And I go to "Assign1" advanced grading definition page
    And I set the following fields to these values:
      | Name        | Assign1 marking guide     |
      | Description | Marking guide description |
    And I define the following marking guide:
      | Criterion name | Description for students         | Description for markers         | Maximum score |
      | Criteria 1     | Grade 1 description for students | Grade 1 description for markers | 100           |
    And I press "Save marking guide and make it ready"
    And the following "mod_assign > submissions" exist:
      | assign  | user  | onlinetext                           |
      | Assign1 | user1 | This is a submission for assignment  |
      | Assign1 | user2 | This is a submission for assignment  |

  @javascript
  Scenario: Mark and view all grades in submissions table 
    Given I am on the "Assign1" "assign activity" page
    And I navigate to "Submissions" in current page administration
    And I should see "Submitted for grading" in the "User One" "table_row"
    And I click on "Grade" "button"
    And I grade by filling the marking guide with:
      | Grade Criteria 1 | 50 | Excellent work! |
    And I press "Save changes"
    When I follow "View all submissions"
    Then "User One" row "Grade" column of "submissions" table should contain "50,00/100.00"

