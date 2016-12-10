require "rails_helper"

RSpec.describe InterfaceDocumentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/interface_documents").to route_to("interface_documents#index")
    end

    it "routes to #new" do
      expect(:get => "/interface_documents/new").to route_to("interface_documents#new")
    end

    it "routes to #show" do
      expect(:get => "/interface_documents/1").to route_to("interface_documents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/interface_documents/1/edit").to route_to("interface_documents#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/interface_documents").to route_to("interface_documents#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/interface_documents/1").to route_to("interface_documents#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/interface_documents/1").to route_to("interface_documents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/interface_documents/1").to route_to("interface_documents#destroy", :id => "1")
    end

  end
end
