require "rails_helper"

RSpec.describe Admin::InterfaceDocumentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/interface_documents").to route_to("admin/interface_documents#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/interface_documents/new").to route_to("admin/interface_documents#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/interface_documents/1").to route_to("admin/interface_documents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/interface_documents/1/edit").to route_to("admin/interface_documents#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/interface_documents").to route_to("admin/interface_documents#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/interface_documents/1").to route_to("admin/interface_documents#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/interface_documents/1").to route_to("admin/interface_documents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/interface_documents/1").to route_to("admin/interface_documents#destroy", :id => "1")
    end

  end
end
