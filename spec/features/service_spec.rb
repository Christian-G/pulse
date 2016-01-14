require 'spec_helper'

describe "Services" do

  it "should be possible to add a service" do

    visit services_path
    click_on "New Service"

    name = "GEANT intranet"
    description = "Some description about GEANT intranet"

    fill_in "service_name", with: name
    fill_in "service_description", with: description

    click_on "Commit"

    # user should see a succcess message

    Service.count.should == 1
    Service.first.name.should eq name
    Service.first.description.should eq description

  end

end