# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to tests_url
  end
end
