require 'acceptance_helper'

resource "用户申请 接口文档 相关的API " do
  header "Accept", "application/json"
  user_attrs = FactoryGirl.attributes_for(:user)
  header "X-User-Token", user_attrs[:authentication_token]
  header "X-User-Phone", user_attrs[:phone]
  before do 
    @user = create(:user)
  end

  post '/appointments' do
    appointment_attrs = FactoryGirl.attributes_for(:appointment)

    before do
      @interface_documents = create_list(:interface_document, 3)
    end

    parameter :interface_document_ids, "申请的接口集合", require: true, scope: :appointment
    parameter :range, "申请使用的时限{integer类型，0：永久， 1: 一个月， 12：一年
                                    }", require: true, scope: :appointment
    

    let(:interface_document_ids) { "#{@interface_documents.first.id}, #{@interface_documents.second.id}" 
                                  }
    let(:range) {appointment_attrs[:range]}

    example "【】用户提交申请成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end

    describe '用户 提交申请失败' do
      let(:interface_document_ids) {[-1]}
      example "【】用户 提交申请失败" do
        do_request
        puts response_body
        expect(status).to eq(422)
      end
    end
  end

  ############### before_do ################################
  describe 'appointments condition is all correct' do
    before do
      @interface_document = create(:interface_document)
      @appointments = create_list(:appointment, 2, user: @user)
      @appointments.each do |appointment|
        @items = create_list(:appointment_item, 2, appointment: appointment,
                              interface_document: @interface_document)
      end
    end
   
    #################### index #########################
    get 'appointments' do
      parameter :keyword, "申请的状态：(‘checking’待审核，‘accepted’已授权，‘refused’未授权)", required: false

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

    get 'appointments/all_appointment_items' do 
      parameter :keyword, "不传参数默认全部，申请的状态：(‘checking’待审核，‘accepted’已授权，‘refused’未授权) ", required: false
      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:keyword) {"checking"}
      let(:page) {1}
      let(:per_page) {3}

      example "用户查看 指定某些申请项目的所有子项 成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

  end
end