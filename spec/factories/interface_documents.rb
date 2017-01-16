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
#  api_type    :string
#

FactoryGirl.define do
  factory :interface_document do
    title "气象云"
    description "气象云接口..."
	site 'http://61.152.122.112:8080/api/v1/qpfs/locate?'
    api_type "qpf"   
  end
end
