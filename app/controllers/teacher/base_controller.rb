# frozen_string_literal: true

# :reek:MissingSafeMethod { exclude: [ teacher_required! ] }
class Teacher::BaseController < ApplicationController
  # layout 'teacher'

  before_action :teacher_required!

  def teacher_required!
    redirect_to root_path, alert: t('teacher.base.restricted') unless current_user&.teacher?
  end
end
