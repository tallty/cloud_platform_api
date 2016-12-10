# == Schema Information
#
# Table name: interface_documents
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  site        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :interface_document do
    title "MyString"
    description "MyText"
    site "MyString"
  end
end
