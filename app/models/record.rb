# == Schema Information
#
# Table name: records
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  end_time              :date
#  range                 :string
#

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :interface_document

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

  def start_time#开始时间
    self.created_at.to_date
  end

  def end_time#结束时间
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
end
