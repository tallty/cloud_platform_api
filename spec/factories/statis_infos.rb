# == Schema Information
#
# Table name: statis_infos
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :statis_info do
    sequence(:user_id) { |n| "#{n}" }
    sequence(:interface_document_id) { |n| "#{n}" }
  end
end
