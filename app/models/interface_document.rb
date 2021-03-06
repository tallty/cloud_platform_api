# == Schema Information
#
# Table name: interface_documents
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  site              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  frequency         :integer          default(0)
#  api_type          :string
#  interface_sort_id :integer
#

class InterfaceDocument < ApplicationRecord
  belongs_to :interface_sort
  has_many :appointment_items    
  has_many :statis_infos    
  has_many :records    # 申请过的接口记录
  has_many :users, through: :records

  ############# 创建统计信息 #################
  def ceate_statis_info (user_id, interface_document_id)
  	_statis_info = self.statis_infos.create!(
  	                                          user_id: user_id, 
  	                                          interface_document_id:interface_document_id
  	                                        )
  	_statis_info.save!
  end

  #检测接口
  scope :check_api_type, ->(type){ find_by(api_type: type) }
  
  def is_using user
    self.users.include?(user) 
  end

  def is_auditing user
    self.appointment_items.where(appointment: user.appointments).keyword('checking').any?
  end

  def self.index_output interface_documents, interface_sorts, user
    _output = {}
    interface_documents.to_a.chunk{|x|x.interface_sort_id}.each do |x| 
      _output[interface_sorts.find(x[0]).title] = x[1].map do |doc|
        { 
          id: doc.id,
           title: doc.title,
           description: doc.description,
           site: doc.site,
           is_using: doc.is_using(user),
           is_auditing: doc.is_auditing(user),
           interface_sort: doc.interface_sort.title
        }
      end
    end
    _output
  end
  ############################################ 排名情况 ######################################
  # def total_rank#总的排名
  # 	self.class.where("frequency > ?", self.frequency).count + 1
  # end

  # def year_rank#年排名
  #   count = 1
  #   InterfaceDocument.all.each do |api|
  #     count = count + 1 if api.year_frequency > self.year_frequency
  #   end
  #   count 
  # end

  # def month_rank#月排名
  # 	count = 1
  #   InterfaceDocument.all.each do |api|
  #     count = count + 1 if api.month_frequency > self.month_frequency
  #   end
  #   count 
  # end

  # def week_rank#周排名
  # 	count = 1
  #   InterfaceDocument.all.each do |api|
  #     count = count + 1 if api.week_frequency > self.week_frequency
  #   end
  #   count 
  # end

  # def day_rank#日排名
  # 	count = 1
  #   InterfaceDocument.all.each do |api|
  #     count = count + 1 if api.day_frequency > self.day_frequency
  #   end
  #   count 
  # end

  # def hour_rank#小时排名
  # 	count = 1
  #   InterfaceDocument.all.each do |api|
  #     count = count + 1 if api.hour_frequency > self.hour_frequency
  #   end
  #   count 
  # end

  # ############################################ 访问量情况 ########################################
  # def total_frequency#总访问量
  # 	self.frequency
  # end

  # def hour_frequency#时访问量
  #   if self.statis_infos.present?
  #      self.statis_infos.where("created_at > ?", Time.zone.now - 1.hour).count
  #   else
  #     0
  #   end
  # end

  # def day_frequency#天访问量
  #   if self.statis_infos.present?
  #     self.statis_infos.where("created_at > ?", Time.zone.now.midnight).count #从当日0点0份分0秒到现在
  #   else
  #     0
  #   end
  # end

  # def week_frequency#周访问量 #####
  #   if self.statis_infos.present?
  #     self.statis_infos.where("created_at > ?", Time.zone.now - Time.zone.now.wday.days).count #从本周的周一到现在
  #   else
  #     0
  #   end
  # end

  # def month_frequency#月访问量55
  #   if self.statis_infos.present?
  #     self.statis_infos.where("created_at > ?", Time.zone.now - Time.zone.now.day.days).count #从本月的1号到现在
  #   else
  #     0
  #   end
  # end

  # def year_frequency#年访问量
  #   if self.statis_infos.present?
  #     self.statis_infos.where("created_at > ?",  Time.zone.now - Time.zone.now.yday.days).count  #从本年的1月1号到现在  
  #   else
  #     0
  #   end
  # end
end
