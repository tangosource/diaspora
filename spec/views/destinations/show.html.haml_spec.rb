require 'spec_helper'

describe "destinations/show" do
  before(:each) do
    @destination = assign(:destination, stub_model(Destination,
      :summary => "MyText",
      :title => "Title",
      :photo_url => "Photo Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Photo Url/)
  end
end
