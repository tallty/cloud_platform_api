class Admin::AppointmentsController < ApplicationController
  before_action :set_admin_appointment, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @admin_appointments = Admin::Appointment.all
    respond_with(@admin_appointments)
  end

  def show
    respond_with(@admin_appointment)
  end

  def create
    @admin_appointment = Admin::Appointment.new(admin_appointment_params)
    @admin_appointment.save
    respond_with(@admin_appointment)
  end

  def update
    @admin_appointment.update(admin_appointment_params)
    respond_with(@admin_appointment)
  end

  def destroy
    @admin_appointment.destroy
    respond_with(@admin_appointment)
  end

  private
    def set_admin_appointment
      @admin_appointment = Admin::Appointment.find(params[:id])
    end

    def admin_appointment_params
      params[:admin_appointment]
    end
end
