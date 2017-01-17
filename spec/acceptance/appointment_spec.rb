require 'acceptance_helper'

resource "用户申请 接口文档 相关的API " do
  header "Accept", "application/json"

  post '/appointments' do
    user_attrs = FactoryGirl.attributes_for(:user)
    appointment_attrs = FactoryGirl.attributes_for(:appointment)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @interface_documents = create_list(:interface_document, 3)
    end

    parameter :interface_document_ids, "申请的接口集合", require: true, scope: :appointment
    parameter :range, "申请使用的时限{integer类型，0：永久， 1: 一个月， 12：一年
                                    }", require: true, scope: :appointment
    

    let(:interface_document_ids) { "#{@interface_documents.first.id}, #{@interface_documents.first.id}" 
                                  }
    let(:range) {appointment_attrs[:range]}

    example "用户提交申请成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

  ############### before_do ################################
  describe 'appointments condition is all correct' do
    user_attrs = FactoryGirl.attributes_for(:user)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @interface_document = create(:interface_document)
      @appointments = create_list(:appointment, 2, user: @user)
      @appointments.each do |appointment|
        @items = create_list(:appointment_item, 2, appointment: appointment,
                              interface_document: @interface_document)
      end
    end
   
    #################### index #########################
    get 'appointments' do
      parameter :keyword, "申请的状态：(‘checking’待审核，‘used’已授权，‘unused’未授权)", required: false

      let(:keyword) {"checking"}

      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "用户 获取 申请列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get 'appointments/:id' do
      let(:id) { @appointments.first.id }

      example "用户 查看指定申请 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end
  end
end