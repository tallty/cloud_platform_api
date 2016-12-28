class AppointmentItemsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :set_appointment_item, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1 
    per_page = params[:per_page] || 20   
    _keyword = params[:keyword]    
    @appointment = current_user.appointments.find(params[:appointment_id])
    @appointment_items = @appointment.appointment_items.keyword(_keyword).paginate(page: page, per_page: per_page)
    respond_with(@appointment_items)
  end

  def show
    respond_with(@appointment_item)
  end
 
  #申请延时
  # def delay
  # # p  _ids = params[:item_ids]
  #   _ids = [1,2] #用于测试
  #   if _ids.present?
  #     _ids.each do |item_id|
  #       @appointment_item = AppointmentItem.find(item_id)
  #       @appointment_item.update(range: item_params[:range], aasm_state: "checking")
  #     end
  #     #返回最后一个对象，用于测试看结果
  #     respond_with(@appointment_item, template:"appointment_items/show", status: 201)
  #   else
  #     @error = "没有需要延时的 申请接口 !"
  #     respond_with(@error, template:"error") 
  #   end
  # end

  private
    def set_appointment_item
      @appointment_item = AppointmentItem.find(params[:id])
    end
   
    def item_params
      params.require(:appointment_item).permit(:range, :aasm_state)
    end

end
