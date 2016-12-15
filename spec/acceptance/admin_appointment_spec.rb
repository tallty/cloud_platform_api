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
      @admin_appointments = create_list(:appointment, 5, user: @user) 
      @admin_appointments.each do |appointment|
        @items = create_list(:appointment_item, 5, appointment: appointment)
      end
    end
   
    #################### index #########################
    get '/admin/appointments' do

      example "管理员获取 申请 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/admin/appointments/:id' do
    
      let(:id) { @admin_appointments.first.id }

      example "管理员 查看 指定申请 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### check ########################
    post '/admin/appointments/:id/accept' do
    
      let(:id) { @admin_appointments.first.id }

      example "管理员 审批通过 申请 的请求" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    ##################### refuse ########################
    post '/admin/appointments/:id/refuse' do
    
      let(:id) { @admin_appointments.last.id }

      example "管理员 审批拒绝 申请 的请求" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end
  end
end