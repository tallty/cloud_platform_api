class SmsTokensController < ApplicationController
  before_action :set_sms_token, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @sms_tokens = SmsToken.all
    respond_with(@sms_tokens)
  end

  def show
    respond_with(@sms_token)
  end

  def create
    @sms_token = SmsToken.new(sms_token_params)
    @sms_token.save
    respond_with(@sms_token)
  end

  def update
    @sms_token.update(sms_token_params)
    respond_with(@sms_token)
  end

  def destroy
    @sms_token.destroy
    respond_with(@sms_token)
  end

  private
    def set_sms_token
      @sms_token = SmsToken.find(params[:id])
    end

    def sms_token_params
      params.require(:sms_token).permit(:phone, :token)
    end
end
