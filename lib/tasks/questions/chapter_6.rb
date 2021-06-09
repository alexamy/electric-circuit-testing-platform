# frozen_string_literal: true

module Questions
  module Chapter6
    TEST = {
      name: 'Раздел 6',
      target_score: 6
    }
    QUESTIONS = {
      1 => {
        scheme_path: 'lib/assets/schemes/601.png',
        text: 'Определить напряжение на выходе ОУ (Out)',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: 'Out=clamp(R5*(In1/R1+In2/R2+In3/R3+In4/R4+In5/R5), Vcc2, Vcc1)',
        parameters: {
          'Vcc1' => { minimum: 5, maximum: 12, step: 1, unit: 'В' },
          'Vcc2' => { minimum: -12, maximum: -5, step: 1, unit: 'В' },
          'In1' => { minimum: 1, maximum: 5, step: 1, unit: 'В' },
          'In2' => { minimum: 1, maximum: 5, step: 1, unit: 'В' },
          'In3' => { minimum: 1, maximum: 5, step: 1, unit: 'В' },
          'In4' => { minimum: 1, maximum: 5, step: 1, unit: 'В' },
          'In5' => { minimum: 1, maximum: 5, step: 1, unit: 'В' },
          'R1' => { minimum: 1_000, maximum: 10_000, step: 1_000, unit: 'Ом' },
          'R2' => { minimum: 1_000, maximum: 10_000, step: 1_000, unit: 'Ом' },
          'R3' => { minimum: 1_000, maximum: 10_000, step: 1_000, unit: 'Ом' },
          'R4' => { minimum: 1_000, maximum: 10_000, step: 1_000, unit: 'Ом' },
          'R5' => { minimum: 1_000, maximum: 10_000, step: 1_000, unit: 'Ом' },
        }
      }
    }
  end
end
