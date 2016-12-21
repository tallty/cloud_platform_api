require 'acceptance_helper'

resource "用户 对接口申请项 相关的API " do
  header "Accept", "application/json"

  ############### before_do ################################
  describe 'appointment_items condition is all correct' do
    user_attrs = FactoryGirl.attributes_for(:user)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @interface_document = create(:interface_document)
      @appointments = create_list(:appointment, 2, user: @user)
      @appointments.each do |appointment|
        @appointment_items = create_list(:appointment_item, 2, appointment: appointment, interface_document: @interface_document)
      end
    end
   
    #################### index #########################
    get '/appointments/:appointment_id/appointment_items' do
      let(:appointment_id) { @appointments.first.id }

      parameter :keyword, "申请的状态：(‘checking’待审核，‘used’已授权，‘unused’未授权)", required: false

      let(:keyword) {"checking"}
      
      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "用户 获取 申请项 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/appointments/:appointment_id/appointment_items/:id' do
    
      let(:id) { @appointment_items.first.id }

      example "用户 查看指定申请项 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/appointment_items/list' do

      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}
      
      example "用户 查看申请过(包括'可用true'和'不可用false',is_available=?)的接口列表 成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end
  end
end