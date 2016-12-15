require 'acceptance_helper'

resource "管理员对 申请项 相关的API " do
  header "Accept", "application/json"

  ############### before_do ################################
  describe 'admin_appointment_items condition is all correct' do
    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    before do
      @admin = create(:admin)
      @interface_document = create(:interface_document)
      @admin_appointment = create(:appointment) 
      @admin_appointment_items = create_list(:appointment_item, 2, appointment: @admin_appointment, 
                                              interface_document: @interface_document)
    end
   
    #################### index #########################
    get '/admin/appointments/:appointment_id/appointment_items' do
      let(:appointment_id) { @admin_appointment.id }

      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "管理员获取 申请项 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/admin/appointments/:appointment_id/appointment_items/:id' do
    
      let(:id) { @admin_appointment_items.first.id }

      example "管理员 查看 指定申请项 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### check ########################
    post '/admin/appointments/:appointment_id/appointment_items/:id/accept' do
    
      let(:id) { @admin_appointment_items.first.id }

      example "管理员 审批通过 申请项 的请求" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    ##################### refuse ########################
    post '/admin/appointments/:appointment_id/appointment_items/:id/refuse' do
    
      let(:id) { @admin_appointment_items.last.id }

      example "管理员 审批拒绝 申请项 的请求" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end
  end
end