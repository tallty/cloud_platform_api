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

require 'rails_helper'

RSpec.describe StatisInfo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
