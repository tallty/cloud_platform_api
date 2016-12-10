require "rails_helper"

RSpec.describe Admin::AppointmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/appointments").to route_to("admin/appointments#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/appointments/new").to route_to("admin/appointments#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/appointments/1").to route_to("admin/appointments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/appointments/1/edit").to route_to("admin/appointments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/appointments").to route_to("admin/appointments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/appointments/1").to route_to("admin/appointments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/appointments/1").to route_to("admin/appointments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/appointments/1").to route_to("admin/appointments#destroy", :id => "1")
    end

  end
end
