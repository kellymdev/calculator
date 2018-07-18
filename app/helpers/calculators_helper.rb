module CalculatorsHelper
  def number_buttons
    (1..9).map do |num|
      button_tag(num, class: num)
    end
  end
end
