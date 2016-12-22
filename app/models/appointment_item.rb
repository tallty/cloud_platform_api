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
#  checke_at             :date
#  range                 :integer
#

class AppointmentItem < ApplicationRecord
  include AASM
  belongs_to :interface_document
  belongs_to :appointment

  # virtual attribute
  attr_accessor :keyword, :item_ids

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

  #状态别名
  def state
    I18n.t :"appointment_aasm_state.#{aasm_state}"
  end

  #搜索
  scope :keyword, -> (keyword) {
    return all if keyword.nil?
    AppointmentItem.all.where( aasm_state: keyword)
  }

  #到期
  scope :expire, ->{ where("self.end_time + 7.day >= ?",Time.zone.today)}
  #开始时间
  def start_time
  	self.appointment.start_time
  end

  #结束时间
  def end_time
  	self.appointment.end_time
  end

  #申请使用时限
  def range_alias 
  	self.appointment.range_alias
  end

  #接口是否有效
  def is_available
    self.aasm_state == "used" && self.end_time >= Time.zone.today
  end
end
