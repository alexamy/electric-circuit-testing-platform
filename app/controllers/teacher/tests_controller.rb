# frozen_string_literal: true

class Teacher::TestsController < Teacher::BaseController
  def index
    @tests = Test.includes(:questions).all
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to teacher_tests_path
    else
      render :new
    end
  end

  def edit
    @test = Test.find(params[:id])
  end

  def update
    @test = Test.find(params[:id])

    if @test.update(test_params)
      redirect_to teacher_tests_path
    else
      render :edit
    end
  end

  def destroy
    Test.find_by(id: params[:id])&.destroy

    redirect_to teacher_tests_path
  end

  private

  def test_params
    params.require(:test)
          .permit(:name, :target_score)
  end
end
