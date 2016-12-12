class Admin::AppointmentsController < ApplicationController
  acts_as_token_authentication_handler_for Admin
  before_action :set_admin_appointment, only: [:show, :accept, :refuse]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @admin_appointments = Appointment.all.paginate(page: page, per_page: per_page)
    respond_with(@admin_appointments)
  end

  def show
    respond_with(@admin_appointment)
  end

  def accept
    @admin_appointment.accept!
    respond_with(@admin_appointment, template:"admin_appointments/show", status: 201)
  end

  def refuse
    @admin_appointment.refuse!
    respond_with(@admin_appointment, template:"admin_appointments/show", status: 201)
  end

  private
    def set_admin_appointment
      @admin_appointment = Appointment.find(params[:id])
    end
end
