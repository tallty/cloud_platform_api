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
  #  开始时间
  def start_time
    self.created_at.to_date
  end
  # 设置结束时间
  def manager_end_time
    _number = self.range.to_i
    if _number > 0
      self.end_time = self.start_time + _number.month
    else
      self.end_time = "永久"
    end
    self.save
  end
  
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
  scope :the_same_interface, ->(id){where(interface_document_id: id)}
  scope :is_using, ->{ where("end_time > ?", Time.zone.now) }

  scope :find_user, ->(user_id){ where(user_id: user_id) }
  scope :find_interface, ->(document_id){find_by(interface_document_id: document_id)}
  # scope :check_user, ->(user_id){ find_by(user_id: user_id) }
  scope :check_user, ->(user_id){ where(user_id: user_id).where("end_time >= ?", Time.zone.today)}
  #延期record
  def self.delay_record record, range
    record.update!(range: range, created_at: Time.zone.now)
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
