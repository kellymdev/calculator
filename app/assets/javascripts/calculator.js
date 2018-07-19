$(document).ready(function() {
  $('.calculator-button').on('click', function(e) {
    e.preventDefault();
    clearAnswer();
    var buttonValue = $(this).text();
    updateCalculatorDisplay(buttonValue);
  });

  $('.clear').on('click', function(e) {
    e.preventDefault();
    clearAnswer();
    clearInputField();
  })
});

function updateCalculatorDisplay(buttonValue) {
  var calculatorDisplayValue = $('#calculation_equation').val();

  $('#calculation_equation').val(calculatorDisplayValue + buttonValue);
}

function clearAnswer() {
  $('.answer p').text('Click calculate to see the answer');
}

function clearInputField() {
  $('#calculation_equation').val('');
}