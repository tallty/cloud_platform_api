# == Schema Information
#
# Table name: appointment_items
#
#  id                    :integer          not null, primary key
#  interface_document_id :integer
#  appointment_id        :integer
#  aasm_state            :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  range                 :string
#

FactoryGirl.define do
  factory :appointment_item do
  	sequence(:interface_document_id) { |n| "#{n}" }
  	sequence(:appointment_id) { |n| "#{n}" }
    aasm_state "checking"
    range "永久"
  end
end
