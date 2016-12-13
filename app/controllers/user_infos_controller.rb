class UserInfosController < ApplicationController
  before_action :set_user_info, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @user_infos = UserInfo.all
    respond_with(@user_infos)
  end

  def show
    respond_with(@user_info)
  end

  def create
    @user_info = UserInfo.new(user_info_params)
    @user_info.save
    respond_with(@user_info)
  end

  def update
    @user_info.update(user_info_params)
    respond_with(@user_info)
  end

  def destroy
    @user_info.destroy
    respond_with(@user_info)
  end

  private
    def set_user_info
      @user_info = UserInfo.find(params[:id])
    end

    def user_info_params
      params.require(:user_info).permit(:user_id, :name, :nickname, :address, :sex)
    end
end
