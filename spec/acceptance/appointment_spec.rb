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
    end

    parameter :user_id, "申请人", require: true, scope: :appointment
    parameter :interface_document_id, "申请的接口", require: true, scope: :appointment
    parameter :start_time, "申请的开始时间", require: true, scope: :appointment
    parameter :end_time, "申请的结束时间", require: true, scope: :appointment

    let(:user_id) {appointment_attrs[:user_id]}
    let(:interface_document_id) {appointment_attrs[:interface_document_id]}
    let(:start_time) {appointment_attrs[:start_time]}
    let(:end_time) {appointment_attrs[:end_time]}

    example "用户提交申请成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

  get 'appointments' do
    user_attrs = FactoryGirl.attributes_for(:user)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @appointments = create_list(:appointment, 5, user: @user)
    end

    example "用户获取申请列表成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end

  get 'appointments/:id' do
    user_attrs = FactoryGirl.attributes_for(:user)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @appointments = create_list(:appointment, 5, user: @user)
    end

    let(:id) { @appointments.first.id }

    example "用户查看指定申请详情成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end
end