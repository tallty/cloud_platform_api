# == Schema Information
#
# Table name: user_infos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  nickname   :string(255)
#  address    :string(255)
#  sex        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserInfo < ApplicationRecord

  belongs_to :user

  delegate :phone, to: :user

  enum sex: [:male, :female]

  def sex_alias
    sex == "male" ? "男" : "女"
  end
end
