# == Schema Information
#
# Table name: records
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  interface_document_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  range                 :string
#  end_time              :date
#

require 'rails_helper'

RSpec.describe Record, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:interface_document) }
end
