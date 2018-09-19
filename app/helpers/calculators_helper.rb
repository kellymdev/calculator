module CalculatorsHelper
  def number_buttons
    (1..9).map do |num|
      button_tag(num, class: "calculator-button button-#{num}")
    end
  end

  def operator_buttons
    operators = %w(+ - * / .)

    operators.map do |operator|
      button_tag(operator, class: "calculator-button button-#{operator}")
    end
  end
end
