require "rails_helper"

RSpec.describe SmsTokensController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sms_tokens").to route_to("sms_tokens#index")
    end

    it "routes to #new" do
      expect(:get => "/sms_tokens/new").to route_to("sms_tokens#new")
    end

    it "routes to #show" do
      expect(:get => "/sms_tokens/1").to route_to("sms_tokens#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sms_tokens/1/edit").to route_to("sms_tokens#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sms_tokens").to route_to("sms_tokens#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sms_tokens/1").to route_to("sms_tokens#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sms_tokens/1").to route_to("sms_tokens#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sms_tokens/1").to route_to("sms_tokens#destroy", :id => "1")
    end

  end
end
