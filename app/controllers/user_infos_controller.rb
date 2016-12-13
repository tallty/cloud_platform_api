class UserInfosController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [:reset] 

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
    respond_with(@user_info, template: "user_infos/show")
  end

  def destroy
    @user_info.destroy
    respond_with(@user_info)
  end

  def reset
    @user = User.reset_user_password reset_params 
    respond_with @user
  end

  private
    def set_user_info
      @user_info = current_user.infocurrent_user.info
    end

    def user_info_params
      params.require(:user_info).permit(:name, :nickname, :address, :sex)
    end

    def reset_params
      params.require(:user).permit( :phone, :password, :sms_token )
    end
end
