require 'rails_helper'

RSpec.describe "InterfaceDocuments", type: :request do
  describe "GET /interface_documents" do
    it "works! (now write some real specs)" do
      get interface_documents_path
      expect(response).to have_http_status(200)
    end
  end
end
