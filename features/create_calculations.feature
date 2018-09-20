Feature: A user can create calculations using a calculator

Scenario: Performing addition via the keyboard
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "1+2" as the equation
    And I click the "Calculate" button
   Then I should see "3.0" as the answer

Scenario: Performing subtraction via the keyboard
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "2-1" as the equation
    And I click the "Calculate" button
   Then I should see "1.0" as the answer

Scenario: Performing multiplication via the keyboard
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "2*3" as the equation
    And I click the "Calculate" button
   Then I should see "6.0" as the answer

Scenario: Performing division via the keyboard
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "5/2" as the equation
    And I click the "Calculate" button
   Then I should see "2.5" as the answer

Scenario: Performing a complex equation via the keyboard
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "9+5*4/10-8" as the equation
    And I click the "Calculate" button
   Then I should see "2.0" as the answer

Scenario: The equation is missing an operator
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "987" as the equation
    And I click the "Calculate" button
   Then I should see the "Equation must contain one of +, -, * or /" error

Scenario: The equation doesn't start and end with a number
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "46+" as the equation
    And I click the "Calculate" button
   Then I should see the "Equation must contain a number either side of an operator" error

Scenario: The equation contains letters
  Given a calculator exists
    And I navigate to the calculator page
   When I enter "4+test-10" as the equation
    And I click the "Calculate" button
   Then I should see the "Equation must not contain any letters" error