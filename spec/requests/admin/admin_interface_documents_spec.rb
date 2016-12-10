require 'rails_helper'

RSpec.describe "Admin::InterfaceDocuments", type: :request do
  describe "GET /admin_interface_documents" do
    it "works! (now write some real specs)" do
      get admin_interface_documents_path
      expect(response).to have_http_status(200)
    end
  end
end
