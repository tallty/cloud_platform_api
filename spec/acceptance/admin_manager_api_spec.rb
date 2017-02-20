require 'acceptance_helper'

resource "管理员 接口管理 相关的API " do
  header "Accept", "application/json"

  ############### before_do ################################
  describe 'admin_manager_apis condition is all correct' do
    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    before do
      @admin = create(:admin)
      @user = create(:user)
      @interface_document = create(:interface_document)
      @records = create_list(:record, 3, user: @user, interface_document: @interface_document, range: 10)
    end
   
    #################### index #########################
    get '/admin/manager_apis' do

      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "管理员获取 API接口管理 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/admin/manager_apis/:id' do
    
      let(:id) { @user.id }

      example "管理员查看 指定API接口管理 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end
  end
end