# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = Student.new
  end

  def create
    @user = Student.new(student_params)

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update; end

  def destroy
    User.find_by(id: params[:id])&.destroy

    redirect_to admin_users_path
  end

  private

  def student_params
    params.require(:user)
          .permit(:email, :password,
                  :group_id,
                  :first_name, :middle_name, :last_name)
  end
end
