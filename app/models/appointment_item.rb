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
      transitions from: :checking, to: :used, :after => :update_item_checke_at
    end

    event :refuse do
      transitions from: :checking, to: :unused
    end
  end

  def update_item_checke_at
    self.update(checke_at: Time.zone.today)
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
  scope :expire_list, ->{ where("self.end_time + 7.day >= ?",Time.zone.today)}

  ################ enum ######################
  #申请使用时限
  enum range: {
    one_month: 0,
    two_month: 1,
    three_month: 3,
    six_month: 4,
    one_year: 5,
    two_year: 6,
    three_year: 7
  }

  Range = {
    one_month: "一个月",
    two_month: "两个月",
    three_month: "三个月",
    six_month: "六个月",
    one_year: "一年",
    two_year: "两年",
    three_year: "三年"
  }

  #申请使用时限
  def range_alias 
  	self.appointment.range_alias
  end

  #接口是否有效
  def is_available
    self.aasm_state == "used" && self.end_time >= Time.zone.today
  end

  def start_time#开始时间
    self.checke_at || Time.zone.today
  end

  def end_time#结束时间
    case range
    when "one_month"
      self.start_time + 1.month
    when "two_month"
      self.start_time + 2.month
    when "three_month"
      self.start_time + 3.month
    when "six_month"
      self.start_time + 6.month
    when "one_year"
      self.start_time + 1.year
    when "two_year"
      self.start_time + 2.year
    when "three_year"
      self.start_time + 3.year
    end
  end
end
