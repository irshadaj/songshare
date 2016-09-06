class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :retrieve_users, only: [:index]

  def show
    if params[:id] && params[:id].to_i != current_user.id
      @user = User.visible.find_by_id(params[:id])
      redirect_to root_url if @user.nil?
    else
      @user = current_user
    end
  end

  private

  def retrieve_users
    @users = User.visible.order(:last_name, :first_name)
  end
end
