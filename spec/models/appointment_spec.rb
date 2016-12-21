# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  aasm_state :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  range      :integer
#  checke_at  :date
#

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:appointment_items) }
end
