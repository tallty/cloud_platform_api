class Admin::AppointmentsController < ApplicationController
  acts_as_token_authentication_handler_for Admin
  before_action :set_admin_appointment, only: [:show, :accept, :audit]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    _keyword = params[:keyword]
    @admin_appointments = Appointment.all.keyword(_keyword).paginate(page: page, per_page: per_page)
    respond_with(@admin_appointments)
  end

  def show
    respond_with(@admin_appointment)
  end

  def audit #state_for_all accepted_ids checking_ids refused_ids
    p "state_for_all is #{params[:state_for_all]}"
    p "accepted_ids is #{params[:accepted_ids]}"
    p "checking_ids is #{params[:checking_ids]}"
    p "refused_ids is #{params[:refused_ids]}"
    @error = @admin_appointment.change_appointment_items_state(params[:state_for_all], params[:accepted_ids], params[:checking_ids], params[:refused_ids])
    @error.nil? ?
      respond_with(@admin_appointment = Appointment.find(params[:id]), template: 'admin/appointments/show') :
      respond_with(@error, template: 'error', status: 422)
  end

  def audit_multi #ids, state_for_all
    @admin_appointments = Appointment.change_multi_appointment_all_state(params[:ids], params[:state_for_all])
    @admin_appointments.is_a?(Appointment::ActiveRecord_Relation) ?
      respond_with(@admin_appointment, template: 'admin/appointments/appointments') :
      respond_with(@error = @admin_appointments, template: 'error', status: 422)
  end

  private
    def set_admin_appointment
      @admin_appointment = Appointment.find(params[:id])
    end
end
