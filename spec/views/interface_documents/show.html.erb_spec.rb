require 'rails_helper'

RSpec.describe "interface_documents/show", type: :view do
  before(:each) do
    @interface_document = assign(:interface_document, InterfaceDocument.create!(
      :title => "Title",
      :description => "MyText",
      :site => "Site"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Site/)
  end
end
