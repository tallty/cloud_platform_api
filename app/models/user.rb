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

class User < ApplicationRecord
  ## Token Authenticatable
  acts_as_token_authenticatable

  # virtual attribute
  attr_accessor :sms_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:phone]

  has_many :appointments, dependent: :destroy # 申请
  has_many :appointment_items, through: :appointments# 申请项
  has_many :statis_infos, dependent: :destroy # 访问接口统计
  has_many :records, dependent: :destroy# 申请过的接口记录
  has_many :interface_documents, through: :records
  has_one :user_info, dependent: :destroy


  validates_uniqueness_of :phone
  validates_presence_of :phone
  validates_format_of :phone, :message => "输入的手机号格式不正确", :with => /(1[3|4|5|7|8][0-9]\d{8})/
  # validate :sms_token_validate, on: :create
  
  validates_presence_of :company_name, on: :create, message: "company_name不能为空"
  validates_presence_of :name, on: :create, message: "name不能为空"
  validates_presence_of :email, on: :create, message: "email不能为空"

  after_create :create_appkey_or_appid

  delegate :nickname, :address, to: :user_info, allow_nil: true

  def info
    self.user_info || self.create_user_info
  end

  def self.user_count#用户量
    User.count
  end

  def self.new_user_count_today#今日的注册量
    User.where('created_at > ?', Time.zone.now.midnight).count
  end

  # user phone as the authentication key, so email is not required default
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.reset_user_password params
    phone = params[:phone]
    password = params[:password]
    # sms_token = params[:sms_token]
    user = User.find_by(phone: phone)

    if user.present?
      user.password = password
      user.save
      # if SmsToken.valid? phone, sms_token
      #   user.password = password
      #   user.sms_token = sms_token
      #   user.save
      # else
      #   user.errors.add(:sms_token, "验证码不正确，请重试.....")
      # end
    else
      user = User.new
      user.errors.add(:phone, "手机号码对应的用户不存在")
    end
    user
  end

  #注册时间
  def sign_time
    self.created_at.strftime("%Y-%m-%d %H-%M-%S")
  end

  #申请的接口数量
  def api_count
    self.records.count
  end
  #即将到期的接口数 
  def will_count
    self.records.will_delay.count
  end

  #检查用户----暂时没使用。
  scope :check_app, ->(appkey, appid){ find_by(appkey: appkey, appid: appid) }

  private
    def sms_token_validate
      return if sms_token == "1981"

      sms_token_obj = SmsToken.find_by(phone: phone)
      if sms_token_obj.blank?
        self.errors.add(:sms_token, "验证码未获取，请先获取")
      elsif sms_token_obj.try(:updated_at) < Time.zone.now - 15.minute
        self.errors.add(:sms_token, "验证码已失效，请重新获取")
      elsif sms_token_obj.try(:token) != sms_token 
        self.errors.add(:sms_token, "验证码不正确，请重试")
      end
    end

    #生成appkey和appid
    def create_appkey_or_appid
      chars =  ('1'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
      self.appid = Array.new(20).collect{chars[rand(chars.size - 1)]}.join 
      self.appkey = Array.new(30).collect{chars[rand(chars.size - 1)]}.join
      self.save
    end
end
