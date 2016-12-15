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
#

class AppointmentItem < ApplicationRecord
  include AASM
  belongs_to :interface_document
  belongs_to :appointment

  ################ aasm ####################
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

  def start_time
  	self.appointment.start_time
  end

  def end_time
  	self.appointment.end_time
  end

  def range_alias #申请使用时限
  	self.appointment.range_alias
  end

  def is_available#是否可用
    self.aasm_state == "used" && self.end_time >= Time.zone.today
  end
end
