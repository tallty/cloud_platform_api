class Admin::AppointmentItemsController < ApplicationController
  acts_as_token_authentication_handler_for Admin, only: [:accept, :refuse]
  before_action :set_admin_appointment_item, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    _keyword =params[:keyword]
    @appointment = Appointment.find(params[:appointment_id])
    @admin_appointment_items = @appointment.appointment_items.keyword(_keyword).paginate(page: page, per_page: per_page)
    respond_with(@admin_appointment_items)
  end

  def show
    respond_with(@admin_appointment_item)
  end

  def accept
    _ids = params[:appointment_item_ids]
    if _ids.present?
      _ids.each do |item_id|
        @admin_appointment_item = AppointmentItem.find_by(id: item_id)
        @admin_appointment_item.check_accept
      end
      #返回最后一个对象，用于测试看结果
      respond_with(@admin_appointment_item, template:"admin/appointment_items/show", status: 201)
    else
      @error = "没有需要审核的 申请项 !"
      respond_with(@error) 
    end
  end

  def refuse
    _ids = params[:appointment_item_ids]
    if _ids.present?
      _ids.each do |item_id|
        @admin_appointment_item = AppointmentItem.find_by(id: item_id)
        @admin_appointment_item.refuse!
      end
      #返回最后一个对象，用于测试看结果
      respond_with(@admin_appointment_item, template:"admin/appointment_items/show", status: 201)
    else
      @error = "没有需要审核的 申请项 !"
      respond_with(@error) 
    end
  end

  private
    def set_admin_appointment_item
      @admin_appointment_item = AppointmentItem.find(params[:id])
    end
end