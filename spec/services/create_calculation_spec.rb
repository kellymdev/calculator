require 'rails_helper'

RSpec.describe CreateCalculation, type: :service do
  describe '#call' do
    let(:calculator) { BasicCalculator.create! }
    let(:service) { CreateCalculation.new(calculator, equation) }

    context 'with a valid equation' do
      context 'using +' do
        context 'without decimal points' do
          let(:equation) { '1+2' }

          it 'adds the two numbers together' do
            expect(service.call).to eq 3
          end
        end

        context 'with decimal points' do
          let(:equation) { '1.1+2.2' }

          it 'adds the two numbers together' do
            expect(service.call).to eq 3.3
          end
        end
      end

      context 'using -' do
        context 'without decimal points' do
          let(:equation) { '1-2' }

          it 'subtracts the two numbers' do
            expect(service.call).to eq -1
          end
        end

        context 'with decimal points' do
          let(:equation) { '1.1-2.2' }

          it 'subtracts the two numbers' do
            expect(service.call).to eq -1.1
          end
        end
      end

      context 'using *' do
        context 'without decimal points' do
          let(:equation) { '1*2' }

          it 'multiplies the two numbers' do
            expect(service.call).to eq 2
          end
        end

        context 'with decimal points' do
          let(:equation) { '1.1*2.2' }

          it 'multiplies the two numbers' do
            expect(service.call).to eq 2.42
          end
        end
      end

      context 'using /' do
        context 'without decimal points' do
          let(:equation) { '1/2' }

          it 'divides the two numbers' do
            expect(service.call).to eq 0.5
          end
        end

        context 'with decimal points' do
          let(:equation) { '1.1/2.2' }

          it 'divides the two numbers' do
            expect(service.call).to eq 0.5
          end
        end
      end

      context 'using sqrt' do
        let(:equation) { 'sqrt4' }

        it 'returns the square root of the number' do
          expect(service.call).to eq 2
        end
      end

      context 'using power of' do
        let(:equation) { '2^2' }

        it 'returns the power of the two numbers' do
          expect(service.call).to eq 4
        end
      end

      context 'performing multiple operations' do
        context 'using two of the same operator' do
          context 'multiplication' do
            let(:equation) { '2*3*4' }

            it 'performs the operations in order' do
              expect(service.call).to eq 24
            end
          end

          context 'division' do
            let(:equation) { '20/2/5' }

            it 'performs the operations in order' do
              expect(service.call).to eq 2
            end
          end

          context 'addition' do
            let(:equation) { '1+2+3' }

            it 'performs the operations in order' do
              expect(service.call).to eq 6
            end
          end

          context 'subtraction' do
            let(:equation) { '20-10-4' }

            it 'performs the operations in order' do
              expect(service.call).to eq 6
            end
          end
        end

        context 'using a combination of operators' do
          context 'multiplication and addition' do
            let(:equation) { '1+2*3' }

            it 'performs the multiplication first, then the addition' do
              expect(service.call).to eq 7
            end
          end

          context 'division and subtraction' do
            let(:equation) { '5-6/3' }

            it 'performs the division first, then the subtraction' do
              expect(service.call).to eq 3
            end
          end

          context 'with all operators' do
            let(:equation) { '6+1*9-10/2' }

            it 'performs the multiplication, division, addition and subtraction in order' do
              expect(service.call).to eq 10
            end
          end

          context 'with power of' do
            let(:equation) { '10+2^3' }

            it 'performs the power of first, then addition' do
              expect(service.call).to eq 18
            end
          end

          context 'with square root' do
            let(:equation) { '3+sqrt4' }

            it 'performs the square root first, then addition' do
              expect(service.call).to eq 5
            end
          end

          context 'using decimals' do
            context 'addition and multiplication' do
              let(:equation) { '3+18.82222222222222*3' }

              it 'performs the multiplication first, then addition' do
                expect(service.call).to eq 59.46666666666666
              end
            end

            context 'multiplication and square root' do
              let(:equation) { '2*sqrt10.5' }

              it 'performs the square root first, then multiplication' do
                expect(service.call).to eq 6.48074069840786
              end
            end
          end
        end
      end
    end

    context 'with an invalid equation' do
      context 'when the equation is too short' do
        let(:equation) { '12' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation is too short (minimum is 3 characters) and Equation must contain one of +, -, *, /, ^ or sqrt'
        end
      end

      context 'when the equation contains only a number' do
        let(:equation) { '123' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain one of +, -, *, /, ^ or sqrt'
        end
      end

      context 'when the equation is missing the first number' do
        let(:equation) { '+12' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain a number either side of an operator'
        end
      end

      context 'when the equation is missing the second number' do
        let(:equation) { '12+' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain a number either side of an operator'
        end
      end

      context 'when the equation contains double operators' do
        let(:equation) { '1++2' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain only single instances of an operator'
        end
      end

      context 'when the equation contains a number directly preceding a square root' do
        let(:equation) { '6sqrt4' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain an operator between a number and a square root'
        end
      end

      context 'when the equation contains a letter' do
        context 'with a simple equation' do
          let(:equation) { 'a+2' }

          it 'creates an error on the service' do
            service.call

            expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain a number either side of an operator and Equation must not contain any letters'
          end
        end

        context 'with a complex equation' do
          let(:equation) { '2+a*3' }

          it 'creates an error on the service' do
            service.call

            expect(service.errors.full_messages.to_sentence).to eq 'Equation must not contain any letters'
          end
        end
      end
    end
  end
end
