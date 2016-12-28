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
#

class Appointment < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :appointment_items, dependent: :destroy

  # virtual attribute
  attr_accessor :interface_document_ids, :keyword

  ################ validates ###############
  validate :update_appointment_state
  validates_presence_of :user_id, on: :create, message: "user_id不能为空"
  validates_presence_of :range, on: :create, message: "range不能为空"

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
  
  #搜索
  scope :keyword, -> (keyword) {
    return all if keyword.nil?
    Appointment.all.where( aasm_state: keyword)
  }

  #待审核的数量
  def checke_count
    self.appointment_items.where(aasm_state: 'checking').count
  end

  def appoint_time#申请时间
    self.created_at.to_date
  end

  def company_name#公司名称
    self.user.try(:nickname)
  end

  ################ enum ######################
  #申请使用时限
   enum range: {
    one_month: 0,
    two_month: 1,
    three_month: 2,
    six_month: 3,
    one_year: 4,
    two_year: 5,
    three_year: 6,
    always: 7
  }

  Range = {
    one_month: "一个月",
    two_month: "两个月",
    three_month: "三个月",
    six_month: "六个月",
    one_year: "一年",
    two_year: "两年",
    three_year: "三年",
    always: "永久"
  }

  #时间期限的别名
  def range_alias
    I18n.t :"appointment_range.#{range}"
  end

  #批量创建申请项
  def create_items(ids, appointment_id)
    ids.each do |id|
      _item = self.appointment_items.create(appointment_id: appointment_id, interface_document_id: id)
      _item.save
    end   
  end
end
