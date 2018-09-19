# frozen_string_literal: true

class UpdateCalculatorMemory
  attr_reader :calculator, :action

  MEMORY_PLUS = 'M+'
  MEMORY_MINUS = 'M-'

  def initialize(calculator, action)
    @calculator = calculator
    @action = action
  end

  def call
    memory = new_memory(current_memory)

    update_calculator(memory)
  end

  private
    def current_memory
      calculator.memory || 0
    end

  def new_memory(current_memory)
    case action
    when MEMORY_PLUS
      current_memory + previous_calculation
    when MEMORY_MINUS
      current_memory - previous_calculation
    end
  end

  def previous_calculation
    calculator.previous_calculation&.answer || 0.0
  end

  def update_calculator(memory)
    @calculator.update!(memory: memory)
  end
end
