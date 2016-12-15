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
    title "气象云"
    description "气象云接口..."
    site "https:/home/mc/tallty/cloud_platform_api/doc/api/index.html"
  end
end
