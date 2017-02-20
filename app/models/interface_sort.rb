# == Schema Information
#
# Table name: interface_sorts
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InterfaceSort < ApplicationRecord
	has_many :interface_documents
end
