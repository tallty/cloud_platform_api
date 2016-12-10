class Admin::InterfaceDocumentsController < ApplicationController
  acts_as_token_authentication_handler_for Admin
  before_action :set_admin_interface_document, only: [:show, :update, :destroy]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @admin_interface_documents = InterfaceDocument.all.paginate(page: page, per_page: per_page)
    respond_with(@admin_interface_documents)
  end

  def show
    respond_with(@admin_interface_document)
  end

  def create
    @admin_interface_document = InterfaceDocument.new(admin_interface_document_params)
    if @admin_interface_document.save
      respond_with(@admin_interface_document, template:"admin_interface_documents/show", status: 201)  
    else
      @error = "接口文档创建 失败 ！"
      respond_with(@error)
    end  
  end

  def update
    @admin_interface_document.update(admin_interface_document_params)
    respond_with(@admin_interface_document, template:"admin_interface_documents/show", status: 201)
  end

  def destroy
    @admin_interface_document.destroy
    respond_with(@admin_interface_document)
  end

  private
    def set_admin_interface_document
      @admin_interface_document = InterfaceDocument.find(params[:id])
    end

    def admin_interface_document_params
      params.require(:interface_document).permit(:title, :description, :site)
    end
end
