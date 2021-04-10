# frozen_string_literal: true

# :reek:MissingSafeMethod { exclude: [ admin_required! ] }
class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :admin_required!

  def admin_required!
    redirect_to root_path, alert: t('admin.base.restricted') unless current_user&.admin?
  end
end
