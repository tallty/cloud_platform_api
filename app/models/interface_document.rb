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
  has_many :appointment_items, dependent: :destroy
  has_many :statis_infos, dependent: :destroy
  has_and_belongs_to_many :users
  ############# 创建统计信息 #################
  def ceate_statis_info (user_id, interface_document_id)
  	_statis_info = self.statis_infos.create!(
  	  user_id: user_id, 
  	  interface_document_id:interface_document_id
  	)
  	_statis_info.save!
  end
 
  ############### 排名情况 ###################
  def total_rank#总的排名
  	self.class.where("frequency > ?", self.frequency).count + 1
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
    if self.statis_infos.present?
      self.statis_infos.where("created_at > ?", Time.zone.now - 1.hour).count
    else
      0
    end
  end

  def day_frequency#天访问量
    if self.statis_infos.present?
      self.statis_infos.where("created_at > ?", Time.zone.now.midnight).count
    else
      0
    end
  end

  def week_frequency#周访问量
    if self.statis_infos.present?
      self.statis_infos.where("created_at > ?", Time.zone.now.midnight - 6.day).count
    else
      0
    end
  end

  def month_frequency#月访问量55
    if self.statis_infos.present?
      self.statis_infos.where("created_at > ?",Time.zone.now.midnight - 1.month).count
    else
      0
    end
  end

  def year_frequency#年访问量
    if self.statis_infos.present?
      self.statis_infos.where("created_at > ?", Time.zone.now.midnight - 1.year).count    
    else
      0
    end
  end
end
