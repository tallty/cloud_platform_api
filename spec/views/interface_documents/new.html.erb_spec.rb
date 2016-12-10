require 'rails_helper'

RSpec.describe "interface_documents/new", type: :view do
  before(:each) do
    assign(:interface_document, InterfaceDocument.new(
      :title => "MyString",
      :description => "MyText",
      :site => "MyString"
    ))
  end

  it "renders new interface_document form" do
    render

    assert_select "form[action=?][method=?]", interface_documents_path, "post" do

      assert_select "input#interface_document_title[name=?]", "interface_document[title]"

      assert_select "textarea#interface_document_description[name=?]", "interface_document[description]"

      assert_select "input#interface_document_site[name=?]", "interface_document[site]"
    end
  end
end
