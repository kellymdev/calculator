Given("a calculator exists") do
  @calculator = BasicCalculator.create!
end

Given("the calculator has {string} in memory") do |string|
  @calculator.update!(memory: string.to_d)
end

Given("I navigate to the calculator page") do
  visit(basic_calculator_path(@calculator))
end

Given("I navigate to the Calculators List") do
  visit('/')
end

When("I click the {string} button") do |string|
  click_on(string)
end

When("I click the {string} link") do |string|
  click_on(string)
end

When("I enter {string} as the equation") do |string|
  fill_in('calculation_equation', with: string)
end

Then("I should see {string}") do |string|
  page.has_content?(string)
end

Then("I should see {string} as the answer") do |string|
  within("div.answer") do
    page.has_content?(string)
  end
end

Then("I should see the {string} error") do |string|
  within("div.errors") do
    page.has_content?(string)
  end
end

Then("I should see {string} as the previous calculation") do |string|
  within("td.previous-equation") do
    page.has_content?(string)
  end
end

Then("I should see {string} as the previous answer") do |string|
  within("td.previous-answer") do
    page.has_content?(string)
  end
end

Then("I should see {string} as the memory") do |string|
  within("td.memory") do
    page.has_content?(string)
  end
end