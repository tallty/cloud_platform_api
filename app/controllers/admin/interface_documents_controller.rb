class Admin::InterfaceDocumentsController < ApplicationController
  before_action :set_admin_interface_document, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @admin_interface_documents = Admin::InterfaceDocument.all
    respond_with(@admin_interface_documents)
  end

  def show
    respond_with(@admin_interface_document)
  end

  def create
    @admin_interface_document = Admin::InterfaceDocument.new(admin_interface_document_params)
    @admin_interface_document.save
    respond_with(@admin_interface_document)
  end

  def update
    @admin_interface_document.update(admin_interface_document_params)
    respond_with(@admin_interface_document)
  end

  def destroy
    @admin_interface_document.destroy
    respond_with(@admin_interface_document)
  end

  private
    def set_admin_interface_document
      @admin_interface_document = Admin::InterfaceDocument.find(params[:id])
    end

    def admin_interface_document_params
      params[:admin_interface_document]
    end
end
