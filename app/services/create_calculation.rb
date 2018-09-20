# frozen_string_literal: true

class CreateCalculation
  include ActiveModel::Validations

  OPERATOR_PATTERN = /[\+\-\*\/]/
  SIMPLE_EQUATION_PATTERN = /\A(\d+\.?\d?)([\+\-\*\/])(\d+\.?\d?)\z/
  ENDING_NUMBER_PATTERN = /(\d+\.?\d?)\z/
  STARTING_NUMBER_PATTERN = /\A(.+)(\d+\.?\d?)\z/

  validates :calculator, presence: true
  validates :equation, { length: { minimum: 3 } }
  validate :equation_contains_operator
  validate :equation_contains_more_than_one_number

  attr_reader :calculator, :equation

  def initialize(calculator, equation)
    @calculator = calculator
    @equation = equation
  end

  def call
    return unless valid?

    answer = if simple_equation?(equation)
      calculate_simple_answer(equation)
    else
      calculate_answer
    end

    create_calculation_record(answer)

    answer
  end

  private

  def create_calculation_record(answer)
    calculator.calculations.create!(equation: equation, answer: answer)
  end

  def equation_contains_operator
    errors.add(:equation, "must contain one of +, -, * or /") unless equation.match(OPERATOR_PATTERN)
  end

  def equation_contains_more_than_one_number
    errors.add(:equation, 'must contain a number either side of an operator') unless starts_and_ends_with_number?
  end

  def calculate_simple_answer(equation)
    parts = equation_parts(equation)

    case parts[:operator]
    when '+'
      parts[:number1] + parts[:number2]
    when '-'
      parts[:number1] - parts[:number2]
    when '*'
      parts[:number1] * parts[:number2]
    when '/'
      parts[:number1] / parts[:number2].to_d
    end
  end

  def calculate_answer
    answer = perform_operation(equation, '*')
    answer = perform_operation(answer, '/')
    answer = perform_operation(answer, '+')
    perform_operation(answer, '-').to_d
  end

  def perform_operation(equation, operator)
    return equation unless equation.chars.include?(operator)

    if simple_equation?(equation)
      return calculate_simple_answer(equation).to_s
    end

    match_groups = equation.match(/\A(\d+\.?\d?)[#{operator}](\d+\.?\d?)(.*)\z/)

    if match_groups.present?
      start_of_equation = match_groups[1]
      number_matches = start_of_equation.match(ENDING_NUMBER_PATTERN)
      beginning_of_equation = nil
      number_1 = number_matches[1].to_d
      number_2 = match_groups[2].to_d
      rest_of_equation = match_groups[3]
    else
      match_groups = equation.match(/\A(.*)(\d+\.?\d?)[#{operator}](\d+\.?\d?)(.*)\z/)
      beginning_of_equation = match_groups[1]
      number_1 = match_groups[2].to_d
      number_2 = match_groups[3].to_d
      rest_of_equation = match_groups[4]
    end

    new_number = case operator
    when '*'
      multiply(number_1, number_2)
    when '/'
      divide(number_1, number_2)
    when '+'
      add(number_1, number_2)
    when '-'
      subtract(number_1, number_2)
    end

    new_equation = "#{beginning_of_equation}#{new_number}#{rest_of_equation}"

    perform_operation(new_equation, operator)
  end

  def multiply(number_1, number_2)
    number_1 * number_2
  end

  def divide(number_1, number_2)
    number_1 / number_2
  end

  def add(number_1, number_2)
    number_1 + number_2
  end

  def subtract(number_1, number_2)
    number_1 - number_2
  end

  def starts_and_ends_with_number?
    equation[0].match(/\d/).present? && equation[-1].match(/\d/).present?
  end

  def simple_equation?(equation)
    equation.match(SIMPLE_EQUATION_PATTERN).present?
  end

  def equation_parts(equation)
    matches = equation.match(SIMPLE_EQUATION_PATTERN)

    return unless matches

    {
      number1: matches[1].to_d,
      operator: matches[2],
      number2: matches[3].to_d
    }
  end
end
