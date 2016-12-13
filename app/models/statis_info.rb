# == Schema Information
#
# Table name: statis_infos
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class StatisInfo < ApplicationRecord
  belongs_to :user
  belongs_to :interface_document
end
