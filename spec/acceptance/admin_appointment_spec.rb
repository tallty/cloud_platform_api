require 'acceptance_helper'

resource "管理员对 申请 相关的API " do
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
      @admin_appointments = create_list(:appointment, 5, user: @user, interface_document: @interface_document)
    end
   
    #################### index #########################
    get '/admin/appointments' do

      example "管理员获取 申请文档列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/admin/appointments/:id' do
    
      let(:id) { @admin_appointments.first.id }

      example "管理员 查看 指定申请文档 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### check ########################
    post '/admin/appointments/:id/accept' do
      appointment_attrs = FactoryGirl.attributes_for(:appointment)
    
      let(:id) { @admin_appointments.first.id }

      parameter :aasm_state, "申请状态", require: true, scope: :appointment
     
      let(:aasm_state) {"used"}

      example "管理员 通过 申请文档 的请求" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    ##################### refuse ########################
    post '/admin/appointments/:id/refuse' do
      appointment_attrs = FactoryGirl.attributes_for(:appointment)
    
      let(:id) { @admin_appointments.first.id }

      parameter :aasm_state, "申请状态", require: true, scope: :appointment
     
      let(:aasm_state) {"unused"}

      example "管理员 拒绝 申请文档 的请求" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end
  end
end