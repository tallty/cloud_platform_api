# == Schema Information
#
# Table name: interface_sorts
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :interface_sort do
    sequence(:title) { |n| "分类#{n}" }
  end
end
