# == Schema Information
#
# Table name: records
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  range                 :string
#  end_time              :date
#  

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :interface_document

  after_create :manager_end_time
  # after_update :manager_end_time

  ################# validate ##############
  validates_presence_of :range, on: :create, message: "range不能为空"
  validates_presence_of :user_id, on: :create, message: "user_id不能为空"
  validates_presence_of :interface_document_id, on: :create, message: "interface_document_id不能为空"

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

  def start_time#申请时间
    self.created_at.to_date
  end

  def manager_end_time#结束时间
    # case self.range
    # when "one_month"
    #  self.end_time = self.start_time + 1.month
    # when "two_month"
    #  self.end_time = self.start_time + 2.month
    # when "three_month"
    #  self.end_time = self.start_time + 3.month
    # when "six_month"
    #  self.end_time = self.start_time + 6.month
    # when "one_year"
    #  self.end_time = self.start_time + 1.year
    # when "two_year"
    #  self.end_time = self.start_time + 2.year
    # when "three_year"
    #  self.end_time = self.start_time + 3.year
    # when "always"
    #  self.end_time = "永久"
    # end
    _number = self.range.to_i
    if _number > 0
      self.end_time = self.start_time + _number.month
    else
      self.end_time = "永久"
    end
    self.save
  end

  #处理到期时间
  # def manager_end_time start_time
  #   case self.range
  #   when "one_month"
  #    self.end_time = start_time + 1.month
  #   when "two_month"
  #    self.end_time = start_time + 2.month
  #   when "three_month"
  #    self.end_time = start_time + 3.month
  #   when "six_month"
  #    self.end_time = start_time + 6.month
  #   when "one_year"
  #    self.end_time = start_time + 1.year
  #   when "two_year"
  #    self.end_time = start_time + 2.year
  #   when "three_year"
  #    self.end_time = start_time + 3.year
  #   when "always"
  #    self.end_time = "永久"
  #   end
  # end

  # #延期时更新到期时间
  # def update_end_time
  #   if self.end_time < Time.zone.today
  #     self.manager_end_time(Time.zone.today)
  #   else
  #     self.manager_end_time(self.end_time)
  #   end
  # end
  
  #接口状态（正常或者过期）
  def state
    self.end_time.blank? || Time.zone.today < self.end_time + 1.days
  end
  
  def will_delay
    (Time.zone.today + 7.days) > end_time && end_time > Time.zone.today 
  end

  #即将到期
  scope :will_delay, ->{ where("end_time > ? and end_time < ?", Time.zone.today, Time.zone.today + 7.days)}
  scope :out_of_date, ->{ where("end_time < ?", Time.zone.today)}

  scope :find_user, ->(user_id){ where(user_id: user_id) }
  scope :find_interface, ->(document_id){find_by(interface_document_id: document_id)}
  scope :check_user, ->(user_id){ find_by(user_id: user_id) }
  #延期record
  def self.delay_record record, range
    if record.present? && record.range.to_i > 0  #延期之前的申请不是 “永久”  
      if record.end_time < Time.zone.today #延期时已经过期了 
        record.update(range: range, created_at: Time.zone.today)#改变使用时限和开始时间
      else
        _range = record.range.to_i + range.to_i 
        record.update(range: _range)
      end
    end  
  end

  #新建record
  def self.create_record user_id, document_id, range
    _record = Record.create(
                            user_id: user_id,
                            interface_document_id: document_id,
                            range: range
                            )
    _record.save
  end
end
