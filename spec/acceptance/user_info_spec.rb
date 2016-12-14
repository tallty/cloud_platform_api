require 'acceptance_helper'

resource "用户信息相关接口api" do
  header "Accept", "application/json"

  get "user_info" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @user.info.update_attributes(user_info_attrs)
    end

    example "用户查询自己的信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

  end

  put "user_info" do
    user_attrs = FactoryGirl.attributes_for(:user)
    user_info_attrs = FactoryGirl.attributes_for(:user_info)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
    end

    parameter :nickname, "公司名称", require: false, scope: :user_info
    parameter :sex, "性别【男: male, 女: female】", require: false, scope: :user_info
    parameter :name, "联系人姓名", require: false, scope: :user_info
    parameter :address, "联系地址", require: false, scope: :user_info


    let(:nickname) { user_info_attrs[:nickname] }
    let(:sex) { user_info_attrs[:sex] }
    let(:name) { user_info_attrs[:name] }
    let(:address) { user_info_attrs[:address] }

    example "用户修改自己的信息成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end
end