# frozen_string_literal: true

module Questions
  module Chapter2
    TEST = {
      name: 'Раздел 2',
      target_score: 6
    }
    QUESTIONS = [
      {
        scheme_path: 'lib/assets/schemes/201.png',
        text: 'Определить мощность, рассеиваемую резистором R1',
        answer_unit: 'Вт',
        precision: 2,
        completion_time: 60,
        formula_text: 'P=(VCC/(R1+R2))^2*R1',
        parameters: {
          'R1' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/201.png',
        text: 'Определить мощность, рассеиваемую резистором R2',
        answer_unit: 'Вт',
        precision: 2,
        completion_time: 60,
        formula_text: 'P=(VCC/(R1+R2))^2*R2',
        parameters: {
          'R1' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/203.png',
        text: 'Определить мощность, рассеиваемую резистором R1',
        answer_unit: 'Вт',
        precision: 2,
        completion_time: 60,
        formula_text: "Rx=R1*R5/(R1+R5)\nP=(VCC/(Rx+R2))^2*R2",
        parameters: {
          'R1' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 10, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/204.png',
        text: 'Определить мощность, рассеиваемую резистором R1',
        answer_unit: 'Вт',
        precision: 2,
        completion_time: 60,
        formula_text: "Rx=R1*R5/(R1+R5)\nRy=R2*R3/(R2+R3)\nI=Vcc/(Rx+Ry)\nP=(Vcc-I*Ry)^2/R1",
        parameters: {
          'R1' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 10_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 10, maximum: 50, step: 1, unit: 'В' }
        }
      }
    ]
  end
end
