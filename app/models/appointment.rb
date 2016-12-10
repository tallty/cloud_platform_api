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

class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :interface_document
end
