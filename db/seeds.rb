# frozen_string_literal: true

# users
User.create(email: 'user@test.com', password: 'user')
admin = Admin.create(email: 'admin@test.com', password: Rails.env.ADMIN_PASSWORD)

# categories
Category.create(name: 'Electricity')

# questions
question = Question.new(
  text: 'Вычислить показание вольтметра XMM1',
  answer_unit: 'В',
  precision: 2,
  completion_time: 60,
  category: category,
  author: admin,
  formula_text: 'Vxmm1=VCC*R2/(R1+R2)'
)

question.formula = FormulaParser.call(question.formula_text)
parameters = {
  'R1' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
  'R2' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' },
  'VCC' => { minimum: 2, maximum: 50, step: 1, unit: 'В' },
}

question.formula['dependencies'].each do |name|
  question.formula_parameters.new(name: name, **parameters[name])
end

question.scheme.attach(
  io: File.open(Rails.root.join('db/seeds/scheme/001.png')),
  filename: '001.png',
  content_type: 'image/png'
)

question.save
