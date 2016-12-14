# == Schema Information
#
# Table name: appointments
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  aasm_state            :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  range                 :integer
#

FactoryGirl.define do
  factory :appointment do
    user_id 1
    interface_document_id 1
    aasm_state "checking"
    start_time "#{Time.zone.now + 3.day}"
    end_time "#{Time.zone.now + 50.day}"
  end
end
