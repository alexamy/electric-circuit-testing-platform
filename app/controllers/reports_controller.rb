# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!
end
