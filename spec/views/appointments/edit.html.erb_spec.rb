require 'rails_helper'

RSpec.describe "appointments/edit", type: :view do
  before(:each) do
    @appointment = assign(:appointment, Appointment.create!(
      :user => nil,
      :interface_document => nil,
      :aasm_state => "MyString"
    ))
  end

  it "renders the edit appointment form" do
    render

    assert_select "form[action=?][method=?]", appointment_path(@appointment), "post" do

      assert_select "input#appointment_user_id[name=?]", "appointment[user_id]"

      assert_select "input#appointment_interface_document_id[name=?]", "appointment[interface_document_id]"

      assert_select "input#appointment_aasm_state[name=?]", "appointment[aasm_state]"
    end
  end
end
