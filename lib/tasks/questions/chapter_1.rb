# frozen_string_literal: true

# rubocop:disable all
module Questions
  module Chapter1
    TEST = {
      id: 1,
      name: 'Раздел 1',
      target_score: 6
    }
    START_ID = 1
    QUESTIONS = [
      {
        scheme_path: 'lib/assets/schemes/001.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: 'Vxmm1=VCC*R2/(R1+R2)',
        parameters: {
          'R1' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/002.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: "Rx=R2*R3/(R2+R3)\nVxmm1=VCC*Rx/(R1+Rx)",
        parameters: {
          'R1' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'R3' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      }
    ]
  end
end
# rubocop:enable all
