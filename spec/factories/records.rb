# == Schema Information
#
# Table name: records
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :record do
    user nil
    interface_document nil
  end
end
