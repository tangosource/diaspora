require 'spec_helper'

describe "destinations/edit" do
  before(:each) do
    @destination = assign(:destination, stub_model(Destination,
      :summary => "MyText",
      :title => "MyString",
      :photo_url => "MyString"
    ))
  end

  it "renders the edit destination form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => destinations_path(@destination), :method => "post" do
      assert_select "textarea#destination_summary", :name => "destination[summary]"
      assert_select "input#destination_title", :name => "destination[title]"
      assert_select "input#destination_photo_url", :name => "destination[photo_url]"
    end
  end
end
