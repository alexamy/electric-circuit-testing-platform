# frozen_string_literal: true

module Questions
  module Chapter8
    TEST = {
      name: 'Раздел 8',
      target_score: 6
    }
    QUESTIONS = {
      1 => {
        text: 'На вход N разрядного ЦАП подан десятичный код Code.'\
          ' Определить величину выходного напряжения (Out), если известно Vref.',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: 'Out=Vref*Code/2^N',
        parameters: {
          'N' => { minimum: 8, maximum: 16, step: 1, unit: '' },
          'Vref' => { minimum: 8, maximum: 16, step: 1, unit: 'В' },
          'Code' => { factory: :formula, formula: 'rand(2^N + 1)', unit: '' },
        }
      }
    }
  end
end
