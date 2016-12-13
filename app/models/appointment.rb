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
  include AASM
  belongs_to :user
  belongs_to :interface_document

  aasm do
  	state :unused
  	state :checking, initial: true
  	state :used

  	event :accept do
      transitions from: :checking, to: :used
    end

    event :refuse do
      transitions from: :checking, to: :unused
    end
  end

  def state
    I18n.t :"appointment_aasm_state.#{aasm_state}"
  end

  scope :range_time, -> {where("end_time >= ?", "#{Time.zone.today}")}
  scope :get_user, -> (user_id) { where(user_id: user_id) }
end