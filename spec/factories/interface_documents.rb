# == Schema Information
#
# Table name: interface_documents
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  site        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  frequency   :integer          default(0)
#

FactoryGirl.define do
  factory :interface_document do
    title "MyString"
    description "MyText"
    site "MyString"
  end
end
