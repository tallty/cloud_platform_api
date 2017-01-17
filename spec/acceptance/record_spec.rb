require 'acceptance_helper'

resource "用户查看 申请接口记录 相关的API " do
  header "Accept", "application/json"

  ############### before_do ################################
  describe 'records condition is all correct' do
  	user_attrs = FactoryGirl.attributes_for(:user)

    header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-Phone", user_attrs[:phone]

    before do
      @user = create(:user)
      @interface_document = create(:interface_document)
      @records = create_list(:record, 2, user: @user, interface_document: @interface_document, range: "15")
      @records << create_list(:record, 2, user: @user, interface_document: @interface_document, end_time: Time.zone.today)
    end
   
    #################### index #########################
    get '/records' do
      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "用户查看 申请记录 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    #################### list #########################
    get '/records/list' do
      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "用户查看 即将到期的接口 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/records/:id' do
      parameter :appid, "当前页", required: false
      parameter :appkey, "每页的数量", required: false

      let(:appid) {"dSivOBxBRU6MJk4RY6sE"}
      let(:appkey) {"FAtIStyhxtV5hH7DHECpF19XAfsYCS"}

      let(:id) { @records.first.id }

      example "用户查看指定 申请记录 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end
  end
end