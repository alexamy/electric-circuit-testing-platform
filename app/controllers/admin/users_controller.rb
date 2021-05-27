# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = Student.new
  end

  def create; end

  def edit
    @user = User.find(params[:id])
  end

  def update; end

  def destroy
    User.find_by(id: params[:id])&.destroy

    redirect_to admin_users_path
  end
end
