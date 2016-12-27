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

FactoryGirl.define do
  factory :record do
    sequence(:interface_document_id) { |n| "#{n}" }
  	sequence(:user_id) { |n| "#{n}" }
  	range "three_month"
  end
end
