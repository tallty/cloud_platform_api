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

  def list#用户申请过的接口列表
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @appointment_items = current_user.appointment_items.paginate(page: page, per_page: per_page)
    respond_with(@appointment_items, template:"appointment_items/index", status: 200)
  end

  def show
    respond_with(@appointment_item)
  end

  private
    def set_appointment_item
      @appointment_item = AppointmentItem.find(params[:id])
    end
end
