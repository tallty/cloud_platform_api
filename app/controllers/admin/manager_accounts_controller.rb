class Admin::ManagerAccountsController < ApplicationController
  acts_as_token_authentication_handler_for Admin
  before_action :set_admin, only: [:show, :destroy]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    @admins = Admin.all.paginate(page: page, per_page: per_page)
    respond_with(@admins)
  end

  def show
    respond_with(@admin)
  end

  def destroy
    @admin.destroy
    respond_with(@admin)
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end
end
