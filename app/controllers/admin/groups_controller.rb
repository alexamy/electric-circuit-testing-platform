# frozen_string_literal: true

class Admin::GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to admin_groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to admin_groups_path
    else
      render :edit
    end
  end

  def destroy
    Group.find_by(id: params[:id])&.destroy

    redirect_to admin_groups_path
  end

  private

  def group_params
    params.require(:group)
          .permit(:name, :year)
  end
end
