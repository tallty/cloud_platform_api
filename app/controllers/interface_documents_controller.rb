class InterfaceDocumentsController < ApplicationController
  before_action :set_interface_document, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @interface_documents = InterfaceDocument.all
    respond_with(@interface_documents)
  end

  def show
    respond_with(@interface_document)
  end

  def new
    @interface_document = InterfaceDocument.new
    respond_with(@interface_document)
  end

  def edit
  end

  def create
    @interface_document = InterfaceDocument.new(interface_document_params)
    @interface_document.save
    respond_with(@interface_document)
  end

  def update
    @interface_document.update(interface_document_params)
    respond_with(@interface_document)
  end

  def destroy
    @interface_document.destroy
    respond_with(@interface_document)
  end

  private
    def set_interface_document
      @interface_document = InterfaceDocument.find(params[:id])
    end

    def interface_document_params
      params.require(:interface_document).permit(:title, :description, :site)
    end
end
