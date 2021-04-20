# frozen_string_literal: true

require 'rails_helper'

feature 'User can start test', "
  In order to pass the test
  As an authenticated user
  I would like to start testing
" do
  given(:category) { create(:category) }
  given!(:question) { create(:question, category: category, completion_time: 2) }
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
      expect(page).to have_content 'Схема'
      expect(page).to have_content 'Параметры схемы'
      expect(page).to have_field 'Ответ'
      expect(page).to have_button 'Отправить'
      expect(page).to have_button 'Отправить и завершить'
    end

    scenario 'sees answer precision and units' do
      expect(page).to have_content "Количество знаков после запятой: #{question.precision}"
      expect(page).to have_content "Единицы измерения: #{question.answer_unit}"
    end

    scenario 'proceeds to next question' do
      click_on 'Отправить'

      expect(page).to have_content 'Схема'
      expect(page).to have_field 'Ответ'
      expect(page).to have_button 'Отправить'
    end

    scenario 'exits from testing' do
      click_on 'Отправить и завершить'

      expect(page).to have_content 'Вы вышли из тестирования'
      expect(page).not_to have_field 'Ответ'
    end

    describe 'scoring' do
      scenario 'has score on test' do
        within '.test-score' do
          expect(page).to have_content "0/#{category.target_score}"
        end
      end

      scenario 'can increase his score with correct answer' do
        fill_in 'Ответ', with: 1
        click_on 'Отправить'

        within '.test-score' do
          expect(page).to have_content '1/'
        end
      end

      scenario 'can decrease his score with wrong answer' do
        fill_in 'Ответ', with: 2
        click_on 'Отправить'

        within '.test-score' do
          expect(page).to have_content '-2/'
        end
      end

      scenario 'can pass the test when get enough test score' do
        2.times.each do
          fill_in 'Ответ', with: 1
          click_on 'Отправить'
        end

        expect(page).to have_content 'Вы успешно прошли тест'
      end

      scenario "can't answer more questions when got test mark" do
        2.times.each do
          fill_in 'Ответ', with: 1
          click_on 'Отправить'
        end

        visit tests_path
        click_link category.name

        expect(page).to have_content 'Тест уже пройден'
      end
    end

    describe 'completion time', slow: true, js: true do
      background { accept_alert }

      scenario 'has completion timer' do
        expect(page).to have_content 'Оставшееся время: 2'
      end

      scenario 'completion timer is changing' do
        expect(page).to have_content 'Оставшееся время: 1'
      end

      scenario 'proceed to new question when completion time passed and enter wrong answer' do
        fill_in 'Ответ', with: 2
        expect(page).to have_content '-2/', wait: 4
      end

      scenario 'proceed to new question when completion time passed and enter correct answer' do
        fill_in 'Ответ', with: 1
        expect(page).to have_content '1/', wait: 4
      end
    end
  end
end
