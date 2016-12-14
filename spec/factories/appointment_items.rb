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
#

FactoryGirl.define do
  factory :appointment_item do
    interface_document nil
    appointment nil
    aasm_state "MyString"
  end
end
