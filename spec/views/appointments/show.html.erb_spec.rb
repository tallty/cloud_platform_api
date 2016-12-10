require 'rails_helper'

RSpec.describe "appointments/show", type: :view do
  before(:each) do
    @appointment = assign(:appointment, Appointment.create!(
      :user => nil,
      :interface_document => nil,
      :aasm_state => "Aasm State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Aasm State/)
  end
end
