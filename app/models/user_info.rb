# == Schema Information
#
# Table name: user_infos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  nickname   :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserInfo < ApplicationRecord

  belongs_to :user

  delegate :phone, to: :user
end
