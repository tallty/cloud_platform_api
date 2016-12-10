# == Schema Information
#
# Table name: sms_tokens
#
#  id         :integer          not null, primary key
#  phone      :string(255)
#  token      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SmsToken < ApplicationRecord

  def self.register phone
  	token = (0..9).to_a.sample(4).jion
  	sms_token = SmsToken.find_or_initialize_by(phone: phone)

  	if phone.present?
  	  tpl_id = 1588030
  	  sms_hash = {code: token}
  	  ChinaSMS.use :yunpian, password: "255281473668c1ef1fc752b71ce575d8"
      result = ChinaSMS.to phone, sms_hash, {tpl_id: tpl_id}
      sms_token.token = token
      sms_token.save 
  	end
  	sms_token
  end
end
