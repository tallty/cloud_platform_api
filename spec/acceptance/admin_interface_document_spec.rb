require 'acceptance_helper'

resource "管理员对 接口 相关的API " do
  header "Accept", "application/json"

  post '/admin/interface_documents' do
    admin_attrs = FactoryGirl.attributes_for(:admin)
    interface_document_attrs = FactoryGirl.attributes_for(:interface_document)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    before do
      @admin = create(:admin)
    end

    parameter :title, "接口标题", require: true, scope: :interface_document
    parameter :description, "接口描述", require: true, scope: :interface_document
    parameter :site, "接口链接", require: true, scope: :interface_document

    let(:title) {interface_document_attrs[:title]}
    let(:description) {interface_document_attrs[:description]}
    let(:site) {interface_document_attrs[:site]}

    example "管理员 创建 接口文档成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

  ############### before_do ################################
  describe 'admin_interface_documents condition is all correct' do
    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    before do
      @admin = create(:admin)
      @interface_documents = create_list(:interface_document, 2, title: "XX接口")
      @statis_infos = create_list(:statis_info, 2, interface_document_id: @interface_documents.first.id)
    end
   
    #################### index #########################
    get '/admin/interface_documents' do

      example "管理员 获取 接口文档 列表成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show ########################
    get '/admin/interface_documents/:id' do
    
      let(:id) { @interface_documents.first.id }

      example "管理员 查看 指定接口文档 详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

     ##################### update ########################
    put '/admin/interface_documents/:id' do
      interface_document_attrs = FactoryGirl.attributes_for(:interface_document)
    
      let(:id) { @interface_documents.first.id }

      parameter :title, "接口标题", require: true, scope: :interface_document
      parameter :description, "接口描述", require: true, scope: :interface_document
      parameter :site, "接口链接", require: true, scope: :interface_document

      let(:title) {interface_document_attrs[:title]}
      let(:description) {interface_document_attrs[:description]}
      let(:site) {interface_document_attrs[:site]}

      example "管理员 修改 指定接口文档成功" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    ##################### destroy ########################
    delete '/admin/interface_documents/:id' do
    
      let(:id) { @interface_documents.first.id }

      example "管理员 删除 指定接口文档成功" do
        do_request
        puts response_body
        expect(status).to eq(204)
      end
    end
  end
end