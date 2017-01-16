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

  after_create :create_end_time
  after_update :update_end_time

  ################# validate ##############
  validates_presence_of :range, on: :create, message: "range不能为空"
  validates_presence_of :user_id, on: :create, message: "user_id不能为空"
  validates_presence_of :interface_document_id, on: :create, message: "interface_document_id不能为空"

  #申请使用时限
  def range_alias 
  	 I18n.t :"appointment_range.#{self.range}"
  end

  def start_time#开始时间
    self.created_at.to_date
  end

  def create_end_time#结束时间
    case self.range
    when "one_month"
     self.end_time = self.start_time + 1.month
    when "two_month"
     self.end_time = self.start_time + 2.month
    when "three_month"
     self.end_time = self.start_time + 3.month
    when "six_month"
     self.end_time = self.start_time + 6.month
    when "one_year"
     self.end_time = self.start_time + 1.year
    when "two_year"
     self.end_time = self.start_time + 2.year
    when "three_year"
     self.end_time = self.start_time + 3.year
    when "always"
     self.end_time = "永久"
    end
    self.save
  end

  #处理到期时间
  def manager_end_time start_time
    case self.range
    when "one_month"
     self.end_time = start_time + 1.month
    when "two_month"
     self.end_time = start_time + 2.month
    when "three_month"
     self.end_time = start_time + 3.month
    when "six_month"
     self.end_time = start_time + 6.month
    when "one_year"
     self.end_time = start_time + 1.year
    when "two_year"
     self.end_time = start_time + 2.year
    when "three_year"
     self.end_time = start_time + 3.year
    when "always"
     self.end_time = "永久"
    end
  end

  #延期时更新到期时间
  def update_end_time
    if self.end_time < Time.zone.today
      self.manager_end_time(Time.zone.today)
    else
      self.manager_end_time(self.end_time)
    end
  end
  #接口状态（正常或者过期）
  def state
    Time.zone.today < self.end_time  if self.end_time.present?
  end
  
  #即将到期
  scope :will_delay, ->{ where("end_time > ? and end_time < ?", Time.zone.today, Time.zone.today + 7.days)}
end
