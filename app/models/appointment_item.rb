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
#  range                 :string
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

  ################ aasm ####################
  aasm do
  	state :unused
  	state :checking, initial: true
  	state :used

  	event :accept do
      transitions from: :checking, to: :used, :after => :create_recod
    end

    event :refuse do
      transitions from: :checking, to: :unused, :after => :update_appointment_state
    end
  end

  def create_recod
    _record = Record.where(user_id: self.appointment.user_id).find_by(interface_document_id: self.interface_document_id)
    if _record.present? 
      if _record.range.to_i > 0 #第一次申请了永久，之后再申请就不改变使用时限（有可能出现的情况）
        _range = _record.range.to_i + self.range.to_i 
        _record.update(range: _range)
      end
    else
      _record = Record.create(
                            user_id: self.appointment.user_id,
                            interface_document_id: self.interface_document_id,
                            range: self.range
                            )
      _record.save
    end
    self.update_appointment_state #当申请全部审核了就改变appointment的状态
  end

  #状态别名
  def state
    I18n.t :"appointment_aasm_state.#{aasm_state}"
  end

  #当申请的所有接口 审核过了改变状态
  def update_appointment_state
    _items = self.appointment.appointment_items.where(aasm_state: 'checking')
    self.appointment.accept! unless _items.present?
  end

  #搜索
  scope :keyword, -> (keyword) {
    return all if keyword.blank?
    AppointmentItem.all.where( aasm_state: keyword)
  }
       
  #申请使用时限
  def range_alias 
  	_number = self.range.to_i / 12 
    if _number >= 1
      if self.range.to_i % 12 == 0
        "#{_number}年"
      else
        year = _number.to_i #年
        month = self.range.to_i % 12
        "#{year}年 零 #{month}个月"
      end 
    elsif _number == 0 && self.range.to_i % 12 == 0
      "永久"
    else 
      "#{self.range}个月"
    end
  end

  def appointment_time#申请时间
    self.created_at.to_date 
  end

  #公司名称
  def company_name
    self.appointment.company_name
  end
  
  #拒绝时间
  def refuse_time
    self.updated_at.to_date if self.aasm_state == "unused"
  end
end
