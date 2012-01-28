require 'spec_helper'

describe "destinations/new" do
  before(:each) do
    assign(:destination, stub_model(Destination,
      :summary => "MyText",
      :title => "MyString",
      :photo_url => "MyString"
    ).as_new_record)
  end

  it "renders new destination form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => destinations_path, :method => "post" do
      assert_select "textarea#destination_summary", :name => "destination[summary]"
      assert_select "input#destination_title", :name => "destination[title]"
      assert_select "input#destination_photo_url", :name => "destination[photo_url]"
    end
  end
end
