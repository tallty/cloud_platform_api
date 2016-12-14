require 'acceptance_helper'

resource "用户申请 接口 相关的API " do
  header "Accept", "application/json"

  post '/appointments' do
    user_attrs = FactoryGirl.attributes_for(:user)
    appointment_attrs = FactoryGirl.attributes_for(:appointment)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @interface_document = create(:interface_document)
    end

    parameter :interface_document_ids, "申请的接口集合", require: true, scope: :appointment
    parameter :range, "申请使用的时限{one_month: 0,
                                    two_month: 1,
                                    three_month: 3,
                                    six_month: 4,
                                    one_year: 5,
                                    two_year: 6,
                                    three_year: 7
                                    }", require: true, scope: :appointment
    

    let(:interface_document_ids) { [1, 2, 3] }
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
      @appointments = create_list(:appointment, 5, user: @user, interface_document: @interface_document)
    end
   
    #################### index #########################
    get 'appointments' do

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