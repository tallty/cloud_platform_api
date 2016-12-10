class InterfaceDocumentsController < ApplicationController
  before_action :set_interface_document, only: [:show]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    @interface_documents = InterfaceDocument.all.paginate(page: page, per_page: per_page)
    respond_with(@interface_documents)
  end

  def show
    respond_with(@interface_document)
  end

  private
    def set_interface_document
      @interface_document = InterfaceDocument.find(params[:id])
    end
end
