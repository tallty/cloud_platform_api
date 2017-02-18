class AppointmentsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :set_appointment, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    _keyword = params[:keyword]
    @appointments = current_user.appointments.keyword(_keyword).paginate(page: page, per_page: per_page)
    respond_with(@appointments)
  end

  def show
    respond_with(@appointment)
  end

  def create
    _ids = params[:appointment][:interface_document_ids]
    @appointment = Appointment.create_one(_ids, appointment_params, current_user)
    @appointment.is_a?(Appointment) ? 
      respond_with(@appointment, template: "appointments/show", status: 201) : 
      respond_with(@error = @appointment, template: 'error', status: 422)
  end
      
  private
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:range)
    end
end
