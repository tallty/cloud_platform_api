# == Schema Information
#
# Table name: appointments
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  aasm_state            :string(255)
#  start_time            :date
#  end_time              :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:interface_document) }
end
