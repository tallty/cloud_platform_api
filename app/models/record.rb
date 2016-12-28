# == Schema Information
#
# Table name: records
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  end_time              :string
#  range                 :string
#

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :interface_document

  after_create :create_end_time

  #申请使用时限
  def range_alias 
  	I18n.t :"record_range.#{self.range}"
  end

  #接口状态（正常或者过期）
  def state
    self.end_time.to_date < Time.zone.tomorrow
  end

  def start_time#开始时间
    self.created_at.to_date
  end

  def create_end_time#结束时间
    case self.range
    when "0"
     self.end_time = self.start_time + 1.month
    when "1"
     self.end_time = self.start_time + 2.month
    when "2"
     self.end_time = self.start_time + 3.month
    when "3"
     self.end_time = self.start_time + 6.month
    when "4"
     self.end_time = self.start_time + 1.year
    when "5"
     self.end_time = self.start_time + 2.year
    when "6"
     self.end_time = self.start_time + 3.year
    when "7"
     self.end_time = "永久"
    end
    self.save
  end

  scope :will_delay, ->{ where("end_time > ? and end_time < ?", Time.zone.today - 7.day, Time.zone.tomorrow)}
end
