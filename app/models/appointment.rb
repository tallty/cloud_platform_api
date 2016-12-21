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

class Appointment < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :appointment_items, dependent: :destroy

  # virtual attribute
  attr_accessor :interface_document_ids, :keyword

  ################ aasm ####################
  aasm do
  	state :checking, initial: true
  	state :used

  	event :accept do
      transitions from: :checking, to: :used, :after => :update_appointment_checke_at
    end
  end
  
  def state
    I18n.t :"appointment_aasm_state.#{aasm_state}"
  end

  #当申请的所有接口 审核过了改变状态
  def update_appointment_state
    _items = self.appointment_items.where(aasm_state: 'checking')
    self.accept! if _items.nil?
  end

  #通过对应的所有申请项
  def update_appointment_checke_at
    self.update(checke_at: Time.zone.today)
  end

  #搜索
  scope :keyword, -> (keyword) {
    return all if keyword.nil?
    Appointment.all.where( aasm_state: keyword)
  }

  ################## scope ###################
  scope :avail_time, -> {where(" slef.end_time >= ?", "#{Time.zone.today}")}
  scope :get_user, -> (user_id) { where(user_id: user_id) }
  # scope :item_state, -> {where(aasm_state: 'checking')}

  def is_available#是否可用
    self.aasm_state == "used" && self.end_time >= Time.zone.today
  end

  #待审核的数量
  def checke_count
    self.appointment_items.where(aasm_state: 'checking').count
  end

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

  #时间期限的别名
  def range_alias
    I18n.t :"appointment_range.#{range}"
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
