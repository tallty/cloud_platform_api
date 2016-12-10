require 'rails_helper'

RSpec.describe "SmsTokens", type: :request do
  describe "GET /sms_tokens" do
    it "works! (now write some real specs)" do
      get sms_tokens_path
      expect(response).to have_http_status(200)
    end
  end
end
