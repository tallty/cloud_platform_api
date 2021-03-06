class UserInfosController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [:reset] 

  before_action :set_user_info, only: [:show, :update]

  respond_to :json

  def show
    respond_with(@user_info)
  end

  def update
    @user_info.update(user_info_params)
    respond_with(@user_info, template: "user_infos/show")
  end
  
  def reset
    @user = User.reset_user_password reset_params 
    respond_with @user
  end

  private
    def set_user_info
      @user_info = current_user.info
    end

    def user_info_params
      params.require(:user_info).permit(:name, :nickname, :address, :sex)
    end

    def reset_params
      params.require(:user).permit( :phone, :password, :sms_token )
    end
end
