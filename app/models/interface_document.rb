# == Schema Information
#
# Table name: interface_documents
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  site        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  frequency   :integer          default(0)
#

class InterfaceDocument < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments
  has_many :statis_infos, dependent: :destroy

  ############# 创建统计信息 #################
  def ceate_statis_info (user_id, interface_document_id)
  	_statis_info = self.statis_infos.create!(
  	  user_id: user_id, 
  	  interface_document_id:interface_document_id
  	)
  	_statis_info.save!
  end

  ############### scope ####################
  scope :year_screen_at, ->(year) { where("created_at.year = ?", year) }
  scope :month_screen_at, ->(month) { where("created_at.month = ?", month) }
  scope :day_screen_at, ->(day) { where("created_at.day = ?", day) }
  scope :hour_screen_at, ->(hour) { where("created_at.hour = ?", hour) }
  scope :week_screen_at, ->(week) { where("created_at > ?", week) }
 
  ############### 排名情况 ###################
  def total_rank#总的排名
  	self.class.where("frequency > :frequency", frequency: frequency).count + 1
  end

  def year_rank#年排名
  	self.class.where("frequency > ?", self.year_frequency).count + 1
  end

  def month_rank#月排名
  	self.class.where("frequency > ?", self.month_frequency).count + 1
  end

  def week_rank#周排名
  	self.class.where("frequency > ?", self.week_frequency).count + 1
  end

  def day_rank#日排名
  	self.class.where("frequency > ?", self.day_frequency).count + 1
  end

  def hour_rank#日排名
  	self.class.where("frequency > ?", self.hour_frequency).count + 1
  end

  ############### 访问情况 ###################
  def total_frequency#总访问量
  	self.frequency
  end

  def hour_frequency#时访问量
  	self.statis_infos.hour_screen_at(Time.zone.now.hour).count
  end

  def day_frequency#天访问量
  	self.statis_infos.day_screen_at(Time.zone.now.day).count
  end

  def week_frequency#周访问量
  	self.statis_infos.screen_at(Time.zone.now - 7.day).count
  end

  def month_frequency#月访问量
  	self.statis_infos.month_screen_at(Time.zone.now.month).count
  end

  def year_frequency#年访问量
  	self.statis_infos.year_screen_at(Time.zone.now.year).count
  end
end
