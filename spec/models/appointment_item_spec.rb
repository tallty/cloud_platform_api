# == Schema Information
#
# Table name: appointment_items
#
#  id                    :integer          not null, primary key
#  interface_document_id :integer
#  appointment_id        :integer
#  aasm_state            :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  range                 :string
#

require 'rails_helper'

RSpec.describe AppointmentItem, type: :model do
  it { should belong_to(:appointment) }
  it { should belong_to(:interface_document) }
end
