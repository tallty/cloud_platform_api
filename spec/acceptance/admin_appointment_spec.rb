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
        create_list(:appointment_item, 2, appointment: appointment,
                              interface_document: @interface_document)
      end
    end
   
    #################### index #########################
    get '/admin/appointments' do
      parameter :keyword, "申请的状态：(‘checking’待审核，‘accepted’已授权，‘refused’未授权)", required: false

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

    post 'admin/appointments/:id/audit' do

      describe "申请组 列表： 设置全部申请为“通过”成功" do 
        parameter :state_for_all, "【申请组 列表页】对该申请组 全部替换时， 将此项设为目标状态字符串（accepted, checking, refused）, 其余三个参数将被忽略。", required: false

        let(:state_for_all) { "accepted" }
        let(:id) { @admin_appointments.first.id }
        example "管理员 申请组 列表： 设置全部申请为“通过”成功" do
          do_request
          puts response_body
          expect(status).to eq(200)
        end
      end

      describe "申请组 详情页, 设置全部申请为“通过”成功" do 
        parameter :accepted_ids, "【申请组 详情页】需转换为 “通过”状态的申请小项 id 数组", required: false
        parameter :checking_ids, "【申请组 详情页】需转换为 “申请中”状态的申请小项 id 数组", required: false
        parameter :refused_ids, "【申请组 详情页】需转换为 “拒绝”状态的申请小项 id 数组， 三种状态数组必须包含该申请组的全部申请小项id 否则报错。", required: false
        p 'sssss'
        let(:state_for_all) { nil }
        let(:accepted_ids) { [@admin_appointments.first.appointment_items.collect(&:id)]}#first.id] }
        let(:checking_ids) { []}#[@admin_appointments.first.appointment_items.second.id]}
        let(:refused_ids) { [] }
        let(:id) { @admin_appointments.first.id }

        example "管理员 申请组 请为“通过”成功" do
          do_request
          puts response_body
          expect(status).to eq(200)
        end
      end

    end
  end
end