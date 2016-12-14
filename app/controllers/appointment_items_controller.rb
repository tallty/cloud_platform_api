class AppointmentItemsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :set_appointment_item, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @appointment_items = current_user.appointment_items.paginate(page: page, per_page: per_page)
    respond_with(@appointment_items)
  end

  def show
    respond_with(@appointment_item)
  end

  private
    def set_appointment_item
      @appointment_item = AppointmentItem.find(params[:id])
    end
end
