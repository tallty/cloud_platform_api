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

  ################ aasm ####################
  aasm do
  	state :checking, initial: true
  	state :used

  	event :accept do
      transitions from: :checking, to: :used
    end
  end
  
  def state
    I18n.t :"appointment_aasm_state.#{aasm_state}"
  end
  
  #搜索
  scope :keyword, -> (keyword) {
    return all if keyword.blank?
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
    self.user.try(:company_name)
  end

  # ################ enum ######################
  # #申请使用时限
  #  enum range: {
  #   one_month: 0,
  #   two_month: 1,
  #   three_month: 2,
  #   six_month: 3,
  #   one_year: 4,
  #   two_year: 5,
  #   three_year: 6,
  #   always: 7
  # }

  # Range = {
  #   one_month: "一个月",
  #   two_month: "两个月",
  #   three_month: "三个月",
  #   six_month: "六个月",
  #   one_year: "一年",
  #   two_year: "两年",
  #   three_year: "三年",
  #   always: "永久"
  # }

  #时间期限的别名
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

  def self.create_one(ids, appointment_params, user)
    ActiveRecord::Base.transaction do
      raise "range 错误" if appointment_params[:range].to_i < 0
      _appointment = user.appointments.build(appointment_params)
      raise "appointment 参数错误" unless _appointment.save
      ids.each do |id|
        raise "所选接口不存在" unless _api = InterfaceDocument.find_by_id(id)
        _item = _appointment.appointment_items.build(interface_document_id: id, range: _appointment.range)
        raise "#{_api.title}这条接口申请失败！，" unless _item.save 
      end
      _appointment 
    end 
  rescue => error
     error
  end
end
