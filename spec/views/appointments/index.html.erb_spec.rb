require 'rails_helper'

RSpec.describe "appointments/index", type: :view do
  before(:each) do
    assign(:appointments, [
      Appointment.create!(
        :user => nil,
        :interface_document => nil,
        :aasm_state => "Aasm State"
      ),
      Appointment.create!(
        :user => nil,
        :interface_document => nil,
        :aasm_state => "Aasm State"
      )
    ])
  end

  it "renders a list of appointments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Aasm State".to_s, :count => 2
  end
end
