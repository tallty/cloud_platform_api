# == Schema Information
#
# Table name: user_infos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  nickname   :string
#  address    :string
#  sex        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#

FactoryGirl.define do
  factory :user_info do
    user_id 1
    name "张三丰"
    nickname "上海气象下属公司"
    address "上海松江区XX路XX号"
  end
end
