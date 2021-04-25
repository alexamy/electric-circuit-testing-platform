# frozen_string_literal: true

require 'rails_helper'

feature 'User can start test', "
  In order to pass the test
  As an authenticated user
  I would like to start testing
" do
  given(:category) { create(:category) }
  given!(:question) { create(:question, category: category, completion_time: 65) }
  given(:user) { create(:user) }

  scenario 'Unauthenticated user tries to start testing' do
    visit start_test_attempt_path(category)

    expect(page).to have_content 'Вам необходимо войти в систему'
  end

  describe 'Authenticated user' do
    background { sign_in(user) }

    background do
      visit tests_path
      click_link category.name
    end

    scenario 'starts testing' do
      expect(page).to have_selector 'img.question-scheme'
      expect(page).to have_content 'Параметры схемы'
      expect(page).to have_field 'Ответ'
      expect(page).to have_button 'Ответить'
      expect(page).to have_button 'Ответить и завершить'
    end

    scenario 'sees answer precision and units' do
      expect(page).to have_content "Количество знаков после запятой: #{question.precision}"
      expect(page).to have_content "Единицы измерения: #{question.answer_unit}"
    end

    scenario 'proceeds to next question' do
      click_on 'Ответить'

      expect(page).to have_selector 'img.question-scheme'
      expect(page).to have_field 'Ответ'
      expect(page).to have_button 'Ответить'
    end

    scenario 'exits from testing' do
      click_on 'Ответить и завершить'

      expect(page).to have_content 'Вы вышли из тестирования'
      expect(page).not_to have_field 'Ответ'
    end

    describe 'scoring' do
      scenario 'has score on test' do
        within '.test-score__current' do
          expect(page).to have_content '0'
        end

        within '.test-score__target' do
          expect(page).to have_content category.target_score
        end
      end

      scenario 'can increase his score with correct answer' do
        fill_in 'Ответ', with: 1
        click_on 'Ответить'

        within '.test-score__current' do
          expect(page).to have_content '1'
        end
      end

      scenario 'can decrease his score with wrong answer' do
        fill_in 'Ответ', with: 2
        click_on 'Ответить'

        within '.test-score__current' do
          expect(page).to have_content '-2'
        end
      end

      scenario 'can pass the test when get enough test score' do
        2.times.each do
          fill_in 'Ответ', with: 1
          click_on 'Ответить'
        end

        expect(page).to have_content 'Вы успешно прошли тест'
      end

      scenario "can't answer more questions when got test mark" do
        2.times.each do
          fill_in 'Ответ', with: 1
          click_on 'Ответить'
        end

        visit tests_path
        click_link category.name

        expect(page).to have_content 'Тест уже пройден'
      end
    end

    describe 'completion time', js: true do
      background { accept_alert }

      scenario 'has completion timer' do
        expect(page).to have_content 'Оставшееся время: 01:05'
      end

      scenario 'completion timer is changing by seconds' do
        PageTimer.tick(1000)

        expect(page).to have_content 'Оставшееся время: 01:04'
      end

      scenario 'completion timer is changing by minutes' do
        PageTimer.tick(60_000)

        expect(page).to have_content 'Оставшееся время: 00:05'
      end

      scenario 'proceed to new question with correct answer after some time' do
        fill_in 'Ответ', with: 1

        Timecop.travel(Time.current + 10) do
          PageTimer.tick(10_000)
          click_on 'Ответить'

          within '.test-score__current' do
            expect(page).to have_content '1'
          end
        end
      end

      scenario 'proceed to new question when completion time passed and enter wrong answer' do
        fill_in 'Ответ', with: 2

        Timecop.travel(Time.current + 65) do
          PageTimer.runAll

          within '.test-score__current' do
            expect(page).to have_content '-2'
          end
        end
      end

      scenario "proceed to new question and dont mark current as correct
      when completion time passed and enter correct answer" do
        fill_in 'Ответ', with: 1

        Timecop.travel(Time.current + 65) do
          PageTimer.runAll

          within '.test-score__current' do
            expect(page).to have_content '-2'
          end
        end
      end
    end
  end
end
