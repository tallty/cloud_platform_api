class Admin::ManagerApisController < ApplicationController
  before_action :set_admin_manager_api, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    @admin_manager_apis = User.all.paginate(page: page, per_page: per_page)
    respond_with(@admin_manager_apis)
  end

  def show
    respond_with(@admin_manager_api)
  end

  private
    def set_admin_manager_api
      @admin_manager_api = User.find(params[:id])
    end
end
