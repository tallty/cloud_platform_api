require 'rails_helper'

RSpec.describe "Admin::Appointments", type: :request do
  describe "GET /admin_appointments" do
    it "works! (now write some real specs)" do
      get admin_appointments_path
      expect(response).to have_http_status(200)
    end
  end
end
