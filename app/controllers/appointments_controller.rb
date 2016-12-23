class AppointmentsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :set_appointment, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    _keyword = params[:keyword]
    @appointments = current_user.appointments.keyword(_keyword).paginate(page: page, per_page: per_page)
    respond_with(@appointments)
  end

  def show
    respond_with(@appointment)
  end

  def create
    @appointment = current_user.appointments.build(appointment_params)
    @appointment.user_id = current_user.id
    if @appointment.save
      # _ids = appointment_params[:interface_document_ids].split(",")#接收接口集合
      _ids = [1, 2, 3]#测试
      if _ids.present?
        _ids.each do |_id|
          @item = @appointment.appointment_items.create(appointment_id: @appointment.id, interface_document_id: _id)
          # @item.appointment_id = @appointment.id
          # @item.interface_document_id = _id
          @item.save
          
          #记录用户申请的接口
          @record = current_user.records.create(user_id: current_user.id, interface_document_id: _id)
          @record.save
        end 
        respond_with(@appointment)
      else
        @error = "请选择 要申请 的接口文档 ！"
        respond_with(@error, template: "error")
        @appointment.destroy
      end   
    else
      @error = "接口文档 申请创建 失败 ！"
      respond_with(@error, template: "error")
    end
  end
      
  private
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:user_id, :interface_document_ids, :range)
    end
end
