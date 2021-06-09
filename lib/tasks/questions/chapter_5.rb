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
      },
      3 => {
        scheme_path: 'lib/assets/schemes/503.png',
        text: 'Определите напряжение на выходе (Out), если известны входные напряжения In1,'\
          'сопротивления R1, R2 и напряжения питания ОУ Vcc1, Vcc2.',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: 'Out=clamp(In1*10^(-6)*R2/R1, Vcc2, Vcc1)',
        parameters: {
          'In1' => { minimum: -100, maximum: 100, step: 10, unit: 'мкВ' },
          'Vcc1' => { minimum: 3, maximum: 5, step: 1, unit: 'В' },
          'Vcc2' => { minimum: -5, maximum: -3, step: 1, unit: 'В' },
          'R1' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
          'R2' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
        }
      },
      4 => {
        scheme_path: 'lib/assets/schemes/504.png',
        text: 'Определите напряжение на выходе (Out), если известны входные напряжения In1,'\
          'сопротивления R1, R2 и напряжения питания ОУ Vcc1, Vcc2.',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: 'Out=clamp(In1*10^(-6)*(R2/R1+1), Vcc2, Vcc1)',
        parameters: {
          'In1' => { minimum: -100, maximum: 100, step: 10, unit: 'мкВ' },
          'Vcc1' => { minimum: 3, maximum: 5, step: 1, unit: 'В' },
          'Vcc2' => { minimum: -5, maximum: -3, step: 1, unit: 'В' },
          'R1' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
          'R2' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
        }
      },
      5 => {
        scheme_path: 'lib/assets/schemes/505.png',
        text: 'Определите напряжение на выходе (Out), если известны входные напряжения In1,'\
          'сопротивления R1, R2, R3 и напряжения питания ОУ Vcc1, Vcc2.',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: "Rx=R2*R3/(R2+R3)\nOut=clamp(In1*10^(-6)*(Rx/R1), Vcc2, Vcc1)",
        parameters: {
          'In1' => { minimum: -100, maximum: 100, step: 10, unit: 'мкВ' },
          'Vcc1' => { minimum: 3, maximum: 5, step: 1, unit: 'В' },
          'Vcc2' => { minimum: -5, maximum: -3, step: 1, unit: 'В' },
          'R1' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
          'R2' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
          'R3' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
        }
      },
      6 => {
        scheme_path: 'lib/assets/schemes/506.png',
        text: 'Определите напряжение на выходе (Out), если известны входные напряжения In1,'\
          'сопротивления R1, R2, R3 и напряжения питания ОУ Vcc1, Vcc2.',
        answer_unit: 'В',
        precision: 4,
        completion_time: 60,
        formula_text: "Ry=R2+R3\nRx=R4*Ry/(R4+Ry)\nOut=clamp(In1*10^(-6)*(Rx/R1+1), Vcc2, Vcc1)",
        parameters: {
          'In1' => { minimum: -100, maximum: 100, step: 10, unit: 'мкВ' },
          'Vcc1' => { minimum: 3, maximum: 5, step: 1, unit: 'В' },
          'Vcc2' => { minimum: -5, maximum: -3, step: 1, unit: 'В' },
          'R1' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
          'R2' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
          'R3' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
          'R4' => { minimum: 10_000, maximum: 1_000_000, step: 10_000, unit: 'Ом' },
        }
      }
    }
  end
end
