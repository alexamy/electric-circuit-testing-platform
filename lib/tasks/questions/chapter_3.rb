# frozen_string_literal: true

module Questions
  module Chapter3
    TEST = {
      name: 'Раздел 3',
      target_score: 6
    }
    QUESTIONS = {
      1 => {
        text: 'На цилиндрическое керамическое основание (Dосн) намотали n витков нихромовой проволоки.'\
          ' Диаметр проволоки Dпров, удельное сопротивление нихрома ρ.'\
          ' Определить сопротивление нихромового резистора.',
        answer_unit: 'Ом',
        precision: 4,
        completion_time: 60,
        formula_text: 'R=ρ*Dосн*0.004*n/(Dпров*Dпров)',
        parameters: {
          'Dосн' => { minimum: 5, maximum: 20, step: 1, unit: 'мм' },
          'Dпров' => { minimum: 0.2, maximum: 2, step: 0.1, unit: 'мм' },
          'n' => { minimum: 10, maximum: 1000, step: 10, unit: '' },
          'ρ' => { minimum: 1.1, maximum: 1.1, step: 0, unit: 'Ом*мм2/м' }
        }
      }
    }
  end
end
