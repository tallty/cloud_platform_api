require 'acceptance_helper'

resource "用户查看 接口文档 相关的API " do
  header "Accept", "application/json"
  user_attrs = FactoryGirl.attributes_for(:user)
  
  header "X-User-Token", user_attrs[:authentication_token]
  header "X-User-Phone", user_attrs[:phone]
  ############### before_do ################################
  describe 'interface_documents condition is all correct' do

    before do
      @interface_sorts = create_list(:interface_sort, 2)
      @interface_documents = create_list(:interface_document, 2, title: "气象云平台接口", interface_sort: @interface_sorts.first) + 
                              create_list(:interface_document, 1, title: "气象云平台接口", interface_sort: @interface_sorts.second)
      @user = create(:user)

      create(:record, user: @user, interface_document: @interface_documents.first, range: 10)
    end
   
    #################### index #########################
    get 'interface_documents' do
      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false

      let(:page) {1}
      let(:per_page) {15}

      example "用户获取接口列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get 'interface_documents/:id' do
    
      let(:id) { @interface_documents.first.id }

      example "用户查看指定接口详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    get 'interface_documents/:id/get_detail_json' do 
      let(:id) { @interface_documents.first.id }

      example "用户查看指定接口的 【文档详情】成功" do
          do_request
          puts response_body
          expect(status).to eq(200)
        end
    end
  end
#   ##################### date list ########################
#     get '/interface_documents/list' do
#       user_attrs = FactoryGirl.attributes_for(:user)

#       header "X-User-Token", user_attrs[:authentication_token]
#       header "X-User-Phone", user_attrs[:phone]

#       before do
#         @user = create(:user)
#       end

#       example "查看指导接口 列表" do
#         do_request
#         puts response_body
#         expect(status).to eq(200)
#       end
#     end

#     ##################### date details ########################
#     get '/interface_documents/details' do
#       user_attrs = FactoryGirl.attributes_for(:user)

#       header "X-User-Token", user_attrs[:authentication_token]
#       header "X-User-Phone", user_attrs[:phone]

#       before do
#         @user = create(:user)
#       end
      
#       parameter :url, "接口url(如:'qpf雷达回波/qpf.json')", required: false

#       let(:url) {"qpf雷达回波/qpf.json"}

#       example "查看 指导接口 详情" do
#         do_request
#         puts response_body
#         expect(status).to eq(200)
#       end
#     end
end

# resource "用户 调用接口 " do
#   header "Accept", "application/json"
#     ##################### show ########################
#     get 'apis/api_date' do
#       user_attrs = FactoryGirl.attributes_for(:user)

#       header "X-User-Token", user_attrs[:authentication_token]
#       header "X-User-Phone", user_attrs[:phone]
      
#       parameter :appid, "*用户appid（必填）", required: false
#       parameter :appkey, "*用户appkey（必填）", required: false
#       parameter :api_type, "*接口名称（如：QPF雷达回波：api_type=QPF）（必填）", required: false
#       parameter :lon, "经度（可选填）", required: false
#       parameter :lat, "纬度（可选填）", required: false
#       parameter :city_name, "城市名称（可选填）", required: false
#       parameter :unit, "区域（可选填）", required: false

#       describe "访问成功" do
#         before do
#           @user = create(:user)
#           @user.update(appid:"dSivOBxBRU6MJk4RY6sE" , appkey:"FAtIStyhxtV5hH7DHECpF19XAfsYCS")
#           @interface_document = create(:interface_document)
#           @records = create_list(:record, 2, user: @user, interface_document: @interface_document)
#         end
#         let(:appid) {"dSivOBxBRU6MJk4RY6sE"}
#         let(:appkey) {"FAtIStyhxtV5hH7DHECpF19XAfsYCS"}
#         let(:api_type) {"qpf"}
#         let(:lon) {"121"}
#         let(:lat) {"30.123"}
#         let(:city_name) {""}
#         let(:unit) {""}

#         example "用户调用接口成功" do
#           do_request
#           puts response_body
#           expect(status).to eq(200)
#         end
#       end

#       describe "访问失败" do
#         before do
#           @user = create(:user)
#         end
#         let(:appid) {""}
#         let(:appkey) {""}
#         let(:api_type) {"qpf"}
#         let(:lon) {"121"}
#         let(:lat) {"30.123"}
#         let(:city_name) {""}
#         let(:unit) {""}

#         example "当前用户的appid or appkey 不存在 !" do
#           do_request
#           puts response_body
#           expect(status).to eq(422)
#         end
#       end

#       describe "访问失败" do
#         before do
#           @user = create(:user)
#           @interface_document = create(:interface_document)
#           @records = create_list(:record, 2)
#         end
#         let(:appid) {"dSivOBxBRU6MJk4RY6sE"}
#         let(:appkey) {"FAtIStyhxtV5hH7DHECpF19XAfsYCS"}
#         let(:api_type) {"qpf"}
#         let(:lon) {"121"}
#         let(:lat) {"30.123"}
#         let(:city_name) {""}
#         let(:unit) {""}

#         example "您无权访问当前接口，请申请审核通过后再使用 ！" do
#           do_request
#           puts response_body
#           expect(status).to eq(422)
#         end
#       end
#     end
# end