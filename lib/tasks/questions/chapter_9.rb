# frozen_string_literal: true

module Questions
  module Chapter9
    TEST = {
      name: 'Раздел 9',
      target_score: 6
    }
    QUESTIONS = {
      1 => {
        scheme_path: 'lib/assets/schemes/901.png',
        text: 'Определить напряжение Ub на базе транзистора.',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: 'Ub=VCC*R2/(R1+R2)',
        parameters: {
          'R1' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 30, step: 1, unit: 'В' }
        }
      }
    }
  end
end
