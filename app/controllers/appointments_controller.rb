class AppointmentsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :set_appointment, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @appointments = current_user.appointments.paginate(page: page, per_page: per_page)
    respond_with(@appointments)
  end

  def show
    respond_with(@appointment)
  end

  def create
   p _ids = [2]
  # p _ids = params[:interface_document_id]#接收接口集合
    if _ids.present?
      _ids.each do |_id|
        # p _id 
        @appointment = current_user.appointments.build(appointment_params)
        @appointment.user_id = current_user.id
        @appointment.interface_document_id = _id
        if @appointment.save
          # p @appointment
          respond_with(@appointment, template:"appointments/show", status: 201)  
        else
          @error = "接口文档 申请创建 失败 ！"
          respond_with(@error)
        end
      end
    else
      @error = "请选择 要申请 的接口文档 ！"
      respond_with(@error)
    end
  end

  private
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:interface_document_id, :range)
    end
end
