# frozen_string_literal: true

require Rails.root.join('db/seeds/helpers/question_create')

# author
admin = Admin.find_by(email: 'admin@test.com')

# tests
test = Test.find_or_create_by(name: 'Электричество', target_score: 5)

# questions
create_question(
  'db/seeds/schemes/001.png',
  {
    text: 'Вычислить показание вольтметра XMM1',
    answer_unit: 'В',
    precision: 2,
    completion_time: 60,
    test: test,
    author: admin,
    formula_text: 'Vxmm1=VCC*R2/(R1+R2)'
  },
  {
    'R1' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
    'R2' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
    'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
  }
)

create_question(
  'db/seeds/schemes/002.png',
  {
    text: 'Вычислить показание вольтметра XMM1',
    answer_unit: 'В',
    precision: 2,
    completion_time: 60,
    test: test,
    author: admin,
    formula_text: "Rx=R2*R3/(R2+R3)\nVxmm1=VCC*Rx/(R1+Rx)"
  },
  {
    'R1' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
    'R2' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
    'R3' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
    'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' }
  }
)
