# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def owned?(resource)
    current_user.author_of?(resource)
  end
end
