# frozen_string_literal: true

module Questions
  module Chapter7
    TEST = {
      name: 'Раздел 7',
      target_score: 6
    }
    QUESTIONS = {
      1 => {
        text: 'На вход N разрядного АЦП подан сигнал амплитудой Y Вольт.'\
          ' Определить десятичный код (Code) на выходе, если известно Vref.',
        answer_unit: '',
        precision: 4,
        completion_time: 60,
        formula_text: 'Code=If(Y >= Vref, 2^N-1, (2^N-1)*Y/Vref)',
        parameters: {
          'N' => { minimum: 8, maximum: 16, step: 1 },
          'Vref' => { minimum: 8, maximum: 14, step: 1, unit: 'В' },
          'Y' => { minimum: 0, maximum: 16, step: 1, unit: 'В' },
        }
      }
    }
  end
end
