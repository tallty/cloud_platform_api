class Admin::AppointmentItemsController < ApplicationController
  # acts_as_token_authentication_handler_for Admin, only: [:show, :update]
  before_action :set_admin_appointment_item, only: [:show, :update, :destroy]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @appointment = Appointment.find(params[appointment_id])
    @admin_appointment_items = @appointment.appointment_items.paginate(page: page, per_page: per_page)
    respond_with(@admin_appointment_items)
  end

  def show
    respond_with(@admin_appointment_item)
  end

  private
    def set_admin_appointment_item
      @admin_appointment_item = AppointmentItem.find(params[:id])
    end
end
