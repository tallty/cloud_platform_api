# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  phone                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  authentication_token   :string(30)
#  appkey                 :string
#  appid                  :string
#  company_name           :string
#  name                   :string
#  email                  :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:appointments) }
  it { should have_many(:statis_infos) }
  it { should have_one(:user_info) }
end
