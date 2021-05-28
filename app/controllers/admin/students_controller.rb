# frozen_string_literal: true

class Admin::StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to admin_students_path, notice: t('.successful')
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    params[:student].delete(:password) if params[:student][:password].blank?

    if @student.update(student_params)
      redirect_to admin_students_path, notice: t('.successful')
    else
      render :edit
    end
  end

  def destroy
    Student.find_by(id: params[:id])&.destroy

    redirect_to admin_students_path
  end

  private

  def student_params
    params.require(:student)
          .permit(:email, :password,
                  :group_id,
                  :first_name, :middle_name, :last_name)
  end
end
