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

class InterfaceDocument < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments
end
