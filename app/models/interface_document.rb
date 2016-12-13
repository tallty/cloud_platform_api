# == Schema Information
#
# Table name: interface_documents
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  site        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  frequency   :integer          default(0)
#

class InterfaceDocument < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments

  ############### 排名情况 ###################
  def total_rank#总的排名
  	self.class.where("frequency > :frequency", frequency: frequency).count + 1
  end

  # def year_rank#年排名
  # 	self.class.where("frequency > :frequency").count + 1
  # end

  # def month_rank#月排名
  # 	self.class.where("frequency > :frequency").count + 1
  # end

  # def week_rank#周排名
  # 	self.class.where("frequency > :frequency").count + 1
  # end

  # def day_rank#日排名
  # 	self.class.where("frequency > :frequency").count + 1
  # end

  ############### 访问情况 ###################
  def total_frequency
  	self.frequency
  end

  # def day_frequency
  # 	self.frequency
  # end

  # def week_frequency
  # 	self.frequency
  # end

  # def month_frequency
  # 	self.frequency
  # end

  # def year_frequency
  # 	self.frequency
  # end
end
