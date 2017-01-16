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

require 'rails_helper'

RSpec.describe InterfaceDocument, type: :model do
  it { should have_many(:appointment_items) }
  it { should have_many(:statis_infos) }
end
  
