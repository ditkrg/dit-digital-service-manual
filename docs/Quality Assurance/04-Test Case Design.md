# Test Case Design

A Test Case is a set of actions executed to verify a particular feature or functionality of your software application. A Test Case contains test steps, test data, precondition, and post condition developed for specific test scenarios to verify any requirement.

The test case includes specific variables or conditions, using which a testing engineer can compare expected and actual results to determine whether a software product is functioning as per the requirements of the customer.

## Test Scenario Vs Test Case

Test scenarios are rather vague and cover a wide range of possibilities. Testing is all about being very specific.

For a Test Scenario: Check Login Functionality there many possible test cases are:

- **Test Case 1:** Check results on entering valid User Id & Password
- **Test Case 2:** Check results on entering Invalid User ID & Password
- **Test Case 3:** Check response when a User ID is Empty & Login Button is pressed, and many more

## The format of Standard Test Cases

Below is a format of a standard login Test cases example:

| Test Case ID | Test Case Description              | Test Steps                                                                                       | Test Data                                | Expected Results                          | Actual Results | Pass/Fail                         |
|--------------|------------------------------------|--------------------------------------------------------------------------------------------------|------------------------------------------|-------------------------------------------|----------------|-----------------------------------|
| T01          | Check User Login with vaild Data   | <ol><li>go to the App</li><li>Enter UserID</li><li>Enter password</li><li>Click submit</li></ol> | UserID: `kurd`<br/>Password: `Kurd@gov2` | User should login into an application     | As expected    | <font color="green"> Pass </font> |
| T02          | Check User Login with invaild Data | <ol><li>go to the App</li><li>Enter UserID</li><li>Enter password</li><li>Click submit</li></ol> | UserID: `kurd`<br/>Password: `test@gov2` | User should not login into an application | As expected    | <font color="green"> Pass </font> |

Many times the Test Steps are not simple as above, hence they need documentation. Also, the author of the test case may leave the organization or go on a vacation or is sick and off duty or is very busy with other critical tasks. A recent hire may be asked to execute the test case. Documented steps will help him and also facilitate reviews by other stakeholders.
 
During test execution time, the tester will check expected results against actual results and assign a pass or fail status.

That apart your test case -may have a field like, Pre – Condition which specifies things that must be in place before the test can run. For our test case, a pre-condition would be to have the application installed to have access to the Application under test. A test case may also include Post – Conditions which specifies anything that applies after the test case completes. For our test case, a post-condition would be time & date of login is stored in the database

By the end of the test case execution phase, all the executed test cases should be recorded in a template like [this](https://govkrd.b-cdn.net/Digital%20Service%20Manual/Test%20Case%20Design%20Template.xlsx).