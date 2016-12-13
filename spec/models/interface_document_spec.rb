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
#  frequency   :integer          default(0)
#

require 'rails_helper'

RSpec.describe InterfaceDocument, type: :model do
  it { should have_many(:appointments) }
end
  
