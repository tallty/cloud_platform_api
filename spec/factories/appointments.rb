# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  aasm_state :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  range      :integer
#  checke_at  :date
#

FactoryGirl.define do
  factory :appointment do
    sequence(:user_id) { |n| "#{n}" }
    aasm_state "checking"
    range "one_month"
  end
end
