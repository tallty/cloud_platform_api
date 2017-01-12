class InterfaceDocumentsController < ApplicationController
  acts_as_token_authentication_handler_for User, only: [:show] 
  before_action :set_interface_document, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @interface_documents = InterfaceDocument.all.paginate(page: page, per_page: per_page)
    respond_with(@interface_documents)
  end

  def show
    # _appid = params[:appid]
    # _appkey = params[:appkey]
    # if _appid.present? && _appkey.present?
    #   _user = User.find_by(appkey: _appkey, appid:_appid)
    #   if _user.present?
    #     @interface_document.update(frequency: @interface_document.frequency + 1) #记录访问次数
    #     @interface_document.ceate_statis_info(current_user.id, @interface_document.id)#创建统计信息
    #     respond_with(@interface_document)
    #   else
    #     @error = "current_user not present !"
    #     respond_with(@error,template: 'error', status: 200)
    #   end
    # else
    #   @error = "appid  or appkey not present !"
    #   respond_with(@error,template: 'error', status: 200)
    # end
    respond_with(@interface_document)
  end

  #接口文档信息列表
  def list
    @date_list = DataJson.get_list
    respond_with @date_list, template: '/date'
  end
  #接口文档详情
  def details
    url = params[:url] #|| "qpf雷达回波/qpf.json"
    @date_details = DataJson.get_details(url)
    respond_with @date_details, template: '/date'
  end

  # def show
  #  #访问接口的权限
  #  @appointments = @interface_document.appointments.get_user(current_user.id)#获取接口对应的所有申请。
  #  if @appointments.present?
  #     @appointment = @appointments.avail_time.first#获取接口对应 没有过期的申请。
  #     if @appointment.present?
  #       if @appointment.aasm_state == "used"
  #         @interface_document.update(frequency: @interface_document.frequency + 1) #记录访问次数
  #         @interface_document.ceate_statis_info(current_user.id, @interface_document.id)#创建统计信息
  #         respond_with(@interface_document)
  #       elsif @appointment.aasm_state == "unused"
  #         @error = "您没有访问权限, 您的申请没有通过审核 ！"
  #         respond_with(@error, template: "error")
  #       else
  #         @error = "您没有访问权限, 您的申请还在审核中 ！"
  #         respond_with(@error, template: "error")
  #       end
  #     else
  #       @error = "您没有访问权限, 您的申请已经过期,请重新申请接口审核通过之后再访问 ！"
  #       respond_with(@error, template: "error")
  #     end
  #  else
  #    @error = "您没有访问权限, 请申请接口审核通过之后再访问 ！"
  #    respond_with(@error, template: "error")
  #  end
  # end

  private
    def set_interface_document
      @interface_document = InterfaceDocument.find(params[:id])
    end
end
