class Admin::AppointmentItemsController < ApplicationController
  before_action :set_admin_appointment_item, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @admin_appointment_items = Admin::AppointmentItem.all
    respond_with(@admin_appointment_items)
  end

  def show
    respond_with(@admin_appointment_item)
  end

  def create
    @admin_appointment_item = Admin::AppointmentItem.new(admin_appointment_item_params)
    @admin_appointment_item.save
    respond_with(@admin_appointment_item)
  end

  def update
    @admin_appointment_item.update(admin_appointment_item_params)
    respond_with(@admin_appointment_item)
  end

  def destroy
    @admin_appointment_item.destroy
    respond_with(@admin_appointment_item)
  end

  private
    def set_admin_appointment_item
      @admin_appointment_item = Admin::AppointmentItem.find(params[:id])
    end

    def admin_appointment_item_params
      params[:admin_appointment_item]
    end
end
