# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to(current_user ? tests_url : new_user_session_url)
  end
end
