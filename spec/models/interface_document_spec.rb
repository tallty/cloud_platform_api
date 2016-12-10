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

require 'rails_helper'

RSpec.describe InterfaceDocument, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
