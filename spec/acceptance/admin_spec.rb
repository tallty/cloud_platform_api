require 'acceptance_helper'

resource "管理后台相关接口" do
  header "Accept", "application/json"

  describe 'admin authentication' do

    before do
      @admin = create(:admin)
    end

    post "/admins/sign_in" do

      parameter :email, "登录的邮箱", required: true, scope: :admin
      parameter :password, "登录密码", required: true, scope: :admin

      admin_attrs = FactoryGirl.attributes_for :admin
      let(:email) { admin_attrs[:email] }
      let(:password) { admin_attrs[:password] }

      response_field :id, "用户ID"
      response_field :email, "邮箱"
      response_field :created_at, "创建时间"
      response_field :updated_at, "更新时间"
      response_field :authentication_token, "鉴权Token"

      example "管理员登录成功" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end
  end
end