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
  	state :accepted

  	event :accept do
      transitions from: :checking, to: :accepted
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
  def check_count
    self.appointment_items.where(aasm_state: 'checking').count
  end

  def appoint_time#申请时间
    self.created_at.to_date
  end

  def company_name#公司名称
    self.user.try(:company_name)
  end

  def create_records
    ActiveRecord::Base.transaction do
      self.appointment_items.keyword("accepted").each do |appointment_item|
        _record = self.user.records.the_same_interface(appointment_item.interface_document_id).is_using
        next if _record.any? && Record.delay_record(_record.first, appointment_item.range) #之前申请过就延期
        _record = self.user.records.build(
          interface_document_id: appointment_item.interface_document_id,
          range: appointment_item.range
          )
        _record.save!
      end
    end
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
      ids = ids.split(',').map{|e| e.to_i} if ids.is_a?(String)
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

  def change_appointment_items_state state_for_all=nil, accepted_ids=nil, checking_ids=nil, refused_ids=nil
    raise "禁止对已全部完成审批的申请再次操作" if self.accepted?
    ActiveRecord::Base.transaction do
      # 申请列表 对所有子项操作
      raise '目标状态参数错误' unless state_for_all.nil? || state_for_all.to_sym.in?(AppointmentItem.aasm.state_machine.states.collect(&:name))
      return nil if state_for_all && self.appointment_items.each {|appointment_item| appointment_item.send("#{state_for_all}!")}
      # 申请详情 分类操作
      _ids_info = [[accepted_ids, "accepted"], [checking_ids, "checking"], [refused_ids, "refused"]].map {|item| [ item[0].is_a?(String) ? item[0].split(',').map{|i| i.to_i} : item[0] ? item[0].map { |i| i.to_i } : [], item[1]]}
      _all_ids = _ids_info.map{|ids, state| ids}.flatten(1)
      _appointment_items = self.appointment_items
      raise '数组参数不完整 或 错误' unless   _all_ids.uniq!.nil? && _all_ids.sort == _appointment_items.collect(&:id).sort
      _ids_info.each {|ids, state| self.appointment_items.where(id: ids).each {|appointment_item| appointment_item.send("#{state}!") } }
      return  nil
    end
  rescue => error
    error
  end

  def self.change_multi_appointment_all_state ids, state_for_all
    raise 'ids 缺失' unless ids
    raise 'state_for_all 缺失或错误' unless state_for_all.is_a?(String) && state_for_all.to_sym.in?(AppointmentItem.aasm.state_machine.states.collect(&:name))
    ids.split(',') if ids.is_a?(String)
    ids = ids.map { |e| e.to_i }
    _appointments = Appointment.keyword('checking')
    raise 'ids 参数错误' unless ids.is_a?(Array) && _appointments.collect(&:id) | ids == _appointments.collect(&:id)
    ActiveRecord::Base.transaction do
      Appointment.where(id: ids).each do |appointment|
        raise "禁止对已全部完成审批的申请再次操作" if appointment.accepted?
        appointment.change_appointment_items_state(state_for_all)
      end
    end
    return Appointment.where(id: ids)
  rescue => error
    error
  end

end
