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

  ################# validate ##############
  validates_presence_of :range, on: :create, message: "range不能为空"
  validates_presence_of :appointment_id, on: :create, message: "appointment_id不能为空"
  validates_presence_of :interface_document_id, on: :create, message: "interface_document_id不能为空"
  validate :is_expiring
  validate :is_expired

  ################ aasm ####################
  aasm do
  	state :unused
  	state :checking, initial: true
  	state :used
    state :expiring
    state :expired


  	event :accept do
      transitions from: :checking, to: :used, :after => :update_item_checke_at
    end

    event :refuse do
      transitions from: :checking, to: :unused
    end

    event :expiring do
      transitions from: :used, to: :expiring
    end

    event :expired do
      transitions from: :expiring, to: :expired
    end
  end

  #获取审核通过的时间
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
  	I18n.t :"appointment_range.#{range}"
  end

  #接口是否有效
  def is_available
    self.aasm_state == "used" && self.end_time.present? && Time.zone.today - 1.day < self.end_time 
  end

  def start_time#开始时间
    self.checke_at || Time.zone.today
  end

  def end_time#结束时间
    self.start_time + 1.month if self.range.nil?
    case self.range
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

   #是否 快过期
  def is_expiring
    self.expiring! if self.end_time.present? && Time.zone.today + 7.day > self.end_time
  end
  
  #是否 已经过期
  def is_expired
    self.expired! if self.end_time.present? && Time.zone.today > self.end_time 
  end
end
