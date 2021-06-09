# frozen_string_literal: true

module Questions
  module Chapter5
    TEST = {
      name: 'Раздел 5',
      target_score: 6
    }
    QUESTIONS = {
      1 => {
        scheme_path: 'lib/assets/schemes/501.png',
        text: 'Определите напряжение на выходе (Out), если известны входные напряжения In1, In2, Кус'\
          'и напряжения питания ОУ Vcc1, Vcc2.',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: 'Out=(In1-In2)*10^(-6)*Кус',
        parameters: {
          'In1' => { minimum: -100, maximum: 100, step: 10, unit: 'мкВ' },
          'In2' => { minimum: -100, maximum: 100, step: 10, unit: 'мкВ' },
          'Кус' => { minimum: -100, maximum: 100, step: 10, unit: 'мкВ' }, # TODO: add variants 10^4, 10^5, 10^6
        }
      }
    }
  end
end
