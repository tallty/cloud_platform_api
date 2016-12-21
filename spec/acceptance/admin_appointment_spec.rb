require 'acceptance_helper'

resource "管理员对 用户申请 相关的API " do
  header "Accept", "application/json"

  ############### before_do ################################
  describe 'admin_appointments condition is all correct' do
    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    before do
      @admin = create(:admin)
      @user = create(:user)
      @interface_document = create(:interface_document)
      @admin_appointments = create_list(:appointment, 2, user: @user) 
      @admin_appointments.each do |appointment|
        @items = create_list(:appointment_item, 2, appointment: appointment,
                              interface_document: @interface_document)
      end
    end
   
    #################### index #########################
    get '/admin/appointments' do
      parameter :keyword, "申请的状态：(‘checking’待审核，‘used’已授权，‘unused’未授权)", required: false

      let(:keyword) {"checking"}

      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "管理员获取 用户申请 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/admin/appointments/:id' do
    
      let(:id) { @admin_appointments.first.id }

      example "管理员 查看 指定用户申请 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end
  end
end