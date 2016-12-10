# == Schema Information
#
# Table name: appointments
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  aasm_state            :string(255)
#  start_time            :date
#  end_time              :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :appointment do
    user nil
    interface_document nil
    aasm_state "MyString"
    start_time "2016-12-10"
    end_time "2016-12-10"
  end
end
