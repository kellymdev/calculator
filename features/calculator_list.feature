Feature: A User can create a new Calculator and use it for calculations

Scenario: Creating a new calculator
  Given I navigate to the Calculators List
   When I click the "New Calculator" button
   Then I should see "Back to calculators"
   When I enter "5+4.9" as the equation
    And I click the "Calculate" button
   Then I should see "9.9" as the answer

Scenario: Using an existing calculator with memory plus
  Given a calculator exists
    And the calculator has "8.0" in memory
    And I navigate to the Calculators List
   When I click the "Show" link
   Then I should see "Back to calculators"
   When I enter "3.5+7" as the equation
    And I click the "Calculate" button
   Then I should see "10.5" as the answer
  Given I click the "M+" button
    And I click the "Back to calculators" link
   Then I should see "3.5+7" as the previous calculation
    And I should see "10.5" as the previous answer
    And I should see "18.5" as the memory

Scenario: Using an existing calculator with memory minus
  Given a calculator exists
    And the calculator has "30.5" in memory
    And I navigate to the calculator page
   Then I should see "Back to calculators"
   When I enter "10*2" as the equation
    And I click the "Calculate" button
   Then I should see "20.0" as the answer
  Given I click the "M-" button
    And I click the "Back to calculators" link
   Then I should see "10*2" as the previous calculation
    And I should see "20.0" as the previous answer
    And I should see "10.5" as the memory