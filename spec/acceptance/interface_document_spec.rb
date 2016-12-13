require 'acceptance_helper'

resource "用户查看 接口 相关的API " do
  header "Accept", "application/json"

  ############### before_do ################################
  describe 'interface_documents condition is all correct' do

    before do
      @interface_documents = create_list(:interface_document, 5, title: "气象云平台接口")
    end
   
    #################### index #########################
    get 'interface_documents' do

      example "用户获取接口列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    #################### list #########################
    get 'interface_documents/list' do
      user_attrs = FactoryGirl.attributes_for(:user)

      header "X-User-Token", user_attrs[:authentication_token]
      header "X-User-Phone", user_attrs[:phone]

      before do
        @user = create(:user)
      end

      example "用户获取 申请过 接口列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get 'interface_documents/:id' do
      user_attrs = FactoryGirl.attributes_for(:user)

      header "X-User-Token", user_attrs[:authentication_token]
      header "X-User-Phone", user_attrs[:phone]

      before do
        @user = create(:user)
      end
    
      let(:id) { @interface_documents.first.id }

      example "用户查看指定接口详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end
  end
end