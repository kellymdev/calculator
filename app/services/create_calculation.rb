# frozen_string_literal: true

class CreateCalculation
  include ActiveModel::Validations

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

    answer = calculate_answer

    create_calculation_record(answer)

    answer
  end

  private

  def create_calculation_record(answer)
    calculator.calculations.create!(equation: equation, answer: answer)
  end

  def equation_contains_operator
    errors.add(:equation, "must contain one of +, -, * or /") unless equation.match(/[\+\-\*\/]/)
  end

  def equation_contains_more_than_one_number
    errors.add(:equation, 'must contain a number either side of an operator') unless equation_parts.present?
  end

  def calculate_answer
    parts = equation_parts

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

  def equation_parts
    matches = equation.match(/\A(\d+)([\+\-\*\/])(\d+)\z/)

    return unless matches

    {
      number1: matches[1].to_i,
      operator: matches[2],
      number2: matches[3].to_i
    }
  end
end
