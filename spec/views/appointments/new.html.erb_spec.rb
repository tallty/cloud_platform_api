require 'rails_helper'

RSpec.describe "appointments/new", type: :view do
  before(:each) do
    assign(:appointment, Appointment.new(
      :user => nil,
      :interface_document => nil,
      :aasm_state => "MyString"
    ))
  end

  it "renders new appointment form" do
    render

    assert_select "form[action=?][method=?]", appointments_path, "post" do

      assert_select "input#appointment_user_id[name=?]", "appointment[user_id]"

      assert_select "input#appointment_interface_document_id[name=?]", "appointment[interface_document_id]"

      assert_select "input#appointment_aasm_state[name=?]", "appointment[aasm_state]"
    end
  end
end
