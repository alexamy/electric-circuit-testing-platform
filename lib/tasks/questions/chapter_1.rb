# frozen_string_literal: true

module Questions
  # rubocop:disable all
  module Chapter1
    START_ID = 1
    DATA = [
      {
        scheme_path: 'lib/assets/schemes/001.png',
        question: {
          text: 'Вычислить показание вольтметра XMM1',
          answer_unit: 'В',
          precision: 2,
          completion_time: 60,
          formula_text: 'Vxmm1=VCC*R2/(R1+R2)'
        },
        parameters: {
          'R1' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/002.png',
        question: {
          text: 'Вычислить показание вольтметра XMM1',
          answer_unit: 'В',
          precision: 2,
          completion_time: 60,
          formula_text: "Rx=R2*R3/(R2+R3)\nVxmm1=VCC*Rx/(R1+Rx)"
        },
        parameters: {
          'R1' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'R3' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      }
    ]
  end
  # rubocop:enable all
end
