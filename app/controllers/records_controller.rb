class RecordsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :set_record, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    @records = current_user.records.paginate(page: page, per_page:per_page)
    respond_with(@records)
  end

  def show
    _appid = params[:appid]
    _appkey = params[:appkey]
    if _appid.present? && _appkey.present?
      _user = User.find_by(appkey: _appkey, appid:_appid)
      if _user.present?
        @interface_document.update(frequency: @interface_document.frequency + 1) #记录访问次数
        @interface_document.ceate_statis_info(current_user.id, @interface_document.id)#创建统计信息
        respond_with(@record)
      else
        @error = "current_user not present !"
        respond_with(@error,template: 'error', status: 200)
      end
    else
      @error = "appid  or appkey not present !"
      respond_with(@error,template: 'error', status: 200)
    end
  end

  private
    def set_record
      @record = Record.find(params[:id])
    end
end
