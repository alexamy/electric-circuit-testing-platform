# frozen_string_literal: true

module Questions
  module Chapter1
    TEST = {
      name: 'Раздел 1',
      target_score: 6
    }
    QUESTIONS = [
      {
        scheme_path: 'lib/assets/schemes/101.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: 'Vxmm1=VCC*R2/(R1+R2)',
        parameters: {
          'R1' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/102.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: "Rx=R2*R3/(R2+R3)\nVxmm1=VCC*Rx/(R1+Rx)",
        parameters: {
          'R1' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R3' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/103.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: "Rx=R1*R3/(R1+R3)\nVxmm1=VCC*R2/(Rx+R2)",
        parameters: {
          'R1' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R3' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/104.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: "Rx=R1*R4/(R1+R4)\nRy=R2*R3/(R2+R3)\nVxmm1=VCC*Ry/(Rx+Ry)",
        parameters: {
          'R1' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R3' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R4' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/105.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: "Vxmm1=VCC*(R2/(R1+R2) - R3/(R3+R4))",
        parameters: {
          'R1' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R3' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R4' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      },
      {
        scheme_path: 'lib/assets/schemes/106.png',
        text: 'Вычислить показание вольтметра XMM1',
        answer_unit: 'В',
        precision: 2,
        completion_time: 60,
        formula_text: "Rx=R1*R3*R5/(R3*R5+R1*R5+R1*R3)\nRy=R2*R4/(R2+R4)\nVxmm1=VCC*Ry/(Rx+Ry)",
        parameters: {
          'R1' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R2' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R3' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R4' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'R5' => { minimum: 100, maximum: 1_000_000, step: 100, unit: 'Ом' },
          'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
        }
      }
    ]
  end
end
