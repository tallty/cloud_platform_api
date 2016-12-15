require 'acceptance_helper'

resource "管理员 帐号管理 相关接口" do
  header "Accept", "application/json"

  post "/admins" do
    admin_attrs = FactoryGirl.attributes_for :admin

    parameter :email, "管理员注册的邮箱号", required: true, scope: :admin
    parameter :password, "管理员注册的密码", required: true, scope: :admin

    describe "管理员注册状态" do
      let(:email) { admin_attrs[:email] }
      let(:password) { admin_attrs[:password] }

      response_field :id, "管理员ID"
      response_field :email, "邮箱"
      response_field :authentication_token, "鉴权Token"
      response_field :created_at, "创建时间"
      response_field :updated_at, "更新时间"
      
      example "管理员注册成功" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end
  end

  ################ sign_in ##############
  post "/admins/sign_in" do
    admin_attrs = FactoryGirl.attributes_for :admin

    before do
      @admin = create(:admin)
    end

    parameter :email, "登录的邮箱", required: true, scope: :admin
    parameter :password, "登录密码", required: true, scope: :admin

    let(:email) { admin_attrs[:email] }
    let(:password) { admin_attrs[:password] }

    response_field :id, "管理员ID"
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

   
  #################### index #########################
  get '/admin/manager_accounts' do
    before do
      @admins = create_list(:admin, 1)
    end

    parameter :page, "当前页", required: false
    parameter :per_page, "每页的数量", required: false

    let(:page) {1}
    let(:per_page) {15}

    example "管理员获取 管理员账户列表成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  ##################### show ########################
  get '/admin/manager_accounts/:id' do
    before do
      @admins = create_list(:admin, 1)
    end
    
    let(:id) { @admins.first.id }

    example "管理员 查看指定管理员账户 详情成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  ##################### delete ########################
  delete '/admin/manager_accounts/:id' do
    # admin_attrs = FactoryGirl.attributes_for(:admin)

    # header "X-Admin-Token", admin_attrs[:authentication_token]
    # header "X-Admin-Phone", admin_attrs[:email]

    before do
      # @admin = create(:admin)
      @admins = create_list(:admin, 1)
    end
    
    let(:id) { @admins.first.id }

    example "管理员 删除指定管理员账户 详情成功" do
      do_request
      puts response_body
      expect(status).to eq(204)
    end
  end
end