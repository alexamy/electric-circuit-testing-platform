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
          'ρ' => { minimum: 1.1, maximum: 1.1, step: 0, unit: 'Ом*мм2/м' },
        }
      },
      2 => {
        text: 'Требуется изготовить проволочный резистор сопротивлением R.'\
          ' Имеется цилиндрическое керамическое основание (Dосн),'\
          ' на которое будет наматываться проволока с удельным сопротивлением ρ и диаметром Dпров.'\
          ' Определить требуемое количество витков n.',
        answer_unit: '',
        precision: 4,
        completion_time: 60,
        formula_text: 'n=R*(Dпров*Dпров)/(ρ*Dосн*4000)',
        parameters: {
          'Dосн' => { minimum: 5, maximum: 20, step: 1, unit: 'мм' },
          'Dпров' => { minimum: 0.2, maximum: 2, step: 0.1, unit: 'мм' },
          'ρ' => { minimum: 1.1, maximum: 1.1, step: 0, unit: 'Ом*мм2/м' },
          'R' => { minimum: 100, maximum: 2_000_000, step: 100, unit: 'Ом' },
        }
      },
      3 => {
        text: 'Имеется переменный резистор сопротивлением R, к которому подключен источник питания напряжением U.'\
          ' В начальный момент времени скользящий контакт вплотную придвинут к контакту резистора,'\
          ' подключенному к нулевому потенциалу источника питания.'\
          ' Определите напряжение на выходе (Uвых), если известно,'\
          ' что максимальный угол поворота скользящего контакт составляет G градусов, а его повернули на Y градусов.',
        answer_unit: '',
        precision: 4,
        completion_time: 60,
        formula_text: 'Uвых=U*Y/G',
        parameters: {
          'U' => { minimum: 1, maximum: 50, step: 1, unit: 'В' },
          'G' => { minimum: 180, maximum: 320, step: 10, unit: '°' },
          'Y' => { minimum: 180, maximum: 320, step: 10, unit: '°' },
        }
      }
    }
  end
end
