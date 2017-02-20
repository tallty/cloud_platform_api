class RecordsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :set_record, only: [:show]

  respond_to :json
  #申请过的
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    @records = current_user.records.paginate(page: page, per_page:per_page)
    respond_with(@records)
  end

  #即将到期
  def list 
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    @records = current_user.records.will_delay.paginate(page: page, per_page: per_page)
    respond_with(@records, template: "records/index", status: 200)
  end

  def out_of_date
    page = params[:page] || 1
    per_page = params[:per_page] || 15
    @records = current_user.records.out_of_date.paginate(page: page, per_page: per_page)
    respond_with(@records, template: "records/index", status: 200)
  end

  def show
    respond_with(@record)  
  end

  private
    def set_record
      @record = Record.find(params[:id])
    end
end
