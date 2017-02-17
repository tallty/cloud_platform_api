class Admin::ManagerAccountsController < ApplicationController
  acts_as_token_authentication_handler_for Admin
  before_action :set_admin, only: [:show, :destroy]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    @admins = Admin.where.not(id: current_admin.id).paginate(page: page, per_page: per_page)
    respond_with(@admins)
  end

  def show
    respond_with(@admin)
  end

  def reset_password
    @admin = Admin.where(email: reset_params[:email]).first
    render nothing: true , status: 422 unless @admin &&  @admin.update(password: reset_params[:password]) && respond_with(@admin, template: 'admin/manager_accounts/show')
  end

  def destroy
    @admin.destroy
    respond_with @admin
  end

  def destroy_others
    @admin = Admin.where(email: reset_params[:email]).first
    render nothing: true , status: 422 unless @admin && reset_params[:email] != current_admin.email && @admin.destroy && respond_with(@admin, template: 'admin/manager_accounts/show', status: 204)
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def reset_params
      params.require(:admin).permit(:email, :password)
    end
end
