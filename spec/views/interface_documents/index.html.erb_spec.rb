require 'rails_helper'

RSpec.describe "interface_documents/index", type: :view do
  before(:each) do
    assign(:interface_documents, [
      InterfaceDocument.create!(
        :title => "Title",
        :description => "MyText",
        :site => "Site"
      ),
      InterfaceDocument.create!(
        :title => "Title",
        :description => "MyText",
        :site => "Site"
      )
    ])
  end

  it "renders a list of interface_documents" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Site".to_s, :count => 2
  end
end
