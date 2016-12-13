# == Schema Information
#
# Table name: user_infos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  nickname   :string(255)
#  address    :string(255)
#  sex        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserInfo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
